=begin
The MIT License

Copyright (c) 2010 Adam Kapelner and Dana Chandler

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
=end

module SurveyTrueAndCheckQuestions
  include SurveyRandomizationSupport 
  include SurveyInstructionalManipulationChecks
  
=begin

Documentation for how to create questions. These are all the keys in
the hash (one hash per question). If you want to use an IMC,
add that as one of the questions instead of the hash or add it to the
"SurveyOrder" array at the bottom of the file.

Some of the following keys are required, some are optional. The
required ones are listed first

0 Signature (:signature) REQUIRED
This is a unique identifier for this question. No two
questions can share this ID. If you change the question,
change the signature. DO NOT change the signature if you
already have data... you will not be able to access the data

1 Question Text (:question_text) REQUIRED
This is the text of the question itself

2 Response Type (:response_type) REQUIRED
a) :multiple_of_many
A user can choose as many of the responses as the would like.
In the view, this is implemented as check boxes
b) :one_of_many
The simplest type - a list of options and the user can choose one.
In the view this is implemented as radio buttons
Other response params: no_opinion, randomize_order
c) :rank_order
User has to take each option and rank order them.
In the view this is implemented as radio buttons
d) :likert_scale
User has to rate his response on a scale of {LikertMin, ..., LikertMax}
In the view this is implemented as radio buttons all on one line
Other response params: likert_min, likert_max, likert_min_score, likert_max_score
e) :free_response_small
User has to answer a question as a free response text
In the view this is implemented as a one-line input text control
Other response params: input_max_characters
f) :free_response_large
User has to answer a question as a free response text
In the view this is implemted as a textarea
Other response params: textarea_width, textarea_height
g) :multiple_of_many_as_boxes
A user can choose as many of the responses as the would like.
In the view, this is implemented as rounded boxes like in
Oppenheimer et al, 2009

3 Question Title (:question_title) OPTIONAL
This is the question's title

4 Question Description (:question_description) OPTIONAL
This is the question description

5 Responses (:response_choices) OPTIONAL
The responses of the question as an array of string - code pairs.
The string is what's showed to the respondent and the code is what's
saved in the database (not needed for Likert scale or the free response questions)

6 Question Types (:question_type) OPTIONAL --- Leave this out for standard surveys
a) <NONE> / left out of hash (a normal question)
b) :imc_check (this is an instructional manipulation check)
c) :demographic (this is a demographic question)
d) :need_for_cognition (this is a question related to the need for cognition assessment)

7 Other Params For Response (:other_response_params) OPTIONAL
a) :no_opinion (boolean, defaults to false)
Includes a "no opinion" option.
b) :randomize_order (boolean, defaults to false)
Randomizes the order of responses
c) :likert_min_score (positive integer or zero, default = 1)
The minimum integer in the Likert scale
d) :likert_max_score (positive integer or zero, default = 7)
The maximum integer in the Likert scale
e) :likert_descriptions (array of strings, defaults to blanks)
A description for each of the Likert scores. If you only want
descriptions for the first and the last, enter blank string entries
in the array for those
f) :input_max_characters (natural number, defaults to 20)
The maximum number of a characters in a small free response
g) :textarea_width (natural number, defaults to 300)
The width of the textarea on a large free response
h) :textarea_height (natural number, defaults to 100)
The height of the textarea on a large free response
i) :text_before_free_response (string)
The text that appears right before the free response small textbox
j) :text_after_free_response (string)
The text that appears right after the free response small textbox
k) :text_underneath_free_response (string)
The text that appears underneath the free response small textbox
l) :needs_response (boolean, defaults to true)
Does this question require a response?

8 Randomization text switches (:randomization_text_switches) OPTIONAL
This is a hash whose key(s) are the same key found in the
survey's "treatment" hash. From this key, there is an array. Each
element of the array corresponds to one FILLIN text item preserving
order. Each fill in item is a hash corresponding to the possible
randomizations

8 Submit Text (:submit_text) OPTIONAL
The text in the button that allows the respondent to continue
onward (defaults to "Continue")

Want to have the following features:

9 Do not Randomize (:do_not_randomize) OPTIONAL
If you choose to randomize the true questions (via RandomizeTrueQuestionOrder = true)
and this is marked true, then this question does not randomize as usual

10 Disqualify Unless Response (:disqualify_unless_response) OPTIONAL
If the user didn't answer this question this certain way, they will be disqualified forever

11 Require answer (:require_answer) OPTIONAL (default no)
Do we require an answer from the user?

12 No answer popup text (:no_answer_popup_message)
In the event the user doesn't give an answer, this is the message we popup
=end

  #should we randomize the order of the questions we ask?
  RandomizeTrueQuestionOrder = false
  #should we randomize the order of the check questions?
  RandomizeCheckQuestionOrder = false

  #all the questions we are going to ask as an array
  TrueQuestions = [
    {#this is the beer question found in Thaler, 1985 and echoed in Oppenheimer et al, 2009
      :signature => 'beer_question_thaler_1985',
      :question_title => "Soda Question",
      :question_description => %Q|You are on the beach on a hot day. For
        the last hour you have been thinking about how much you would enjoy an ice cold
        can of soda. Your companion needs to make a phone call and offers to bring
        back a soda from the only nearby place where drinks are sold, which happens
        to be a #{FillInChars[0]}. Your companion asks how much you are willing
        to pay for the soda and will only buy it if it is below the price you state.|,
      :question_text => %Q|How much are you willing to pay?|,
      :response_type => :free_response_small,
      :other_response_params => {
        :input_max_characters => 5,
        :text_before_free_response => '$',
        :text_underneath_free_response => '(only numbers and the decimal point are allowed)'
      },
      :randomization_text_switches => {
        :place => [
          {
            :run_down => 'run-down grocery store',
            :fancy => 'fancy resort'
          }
        ]
      }
    },
    {#this is the football question found in Thaler, 1985 and echoed in Oppenheimer et al, 2009
      :signature => 'football_question_thaler_1985',
      :question_title => "Football Question",
      :question_description => %Q|Imagine that your favorite football team is playing an important
        game. You have a ticket to the game that you #{FillInChars[0]}. However, on the day of the
        game, it happens to be freezing cold.|,
      :question_text => %Q|What do you do?<br/> (1 - definitely stay at home, 9 - definitely go to the game)|,
      :response_type => :likert_scale,
      :other_response_params => {:likert_max_score => 9},
      :randomization_text_switches => {
        :ticket_price => [
          {
            :free => 'have received for free from a friend',
            :paid => 'have paid handsomely for'
          }
        ]
      }
    },
    Oppenheimer99IMC1 #we throw the IMC check in at position #3
  ]
  #.sort_by{RandomizeTrueQuestionOrder ? rand : 0}

  #which questions are we going to ask duplicate after the survey is over
  #these reference the indices in the TrueQuestions array
  CheckQuestionIndices = [] #we are not asking any duplicate check questions this survey
  
end