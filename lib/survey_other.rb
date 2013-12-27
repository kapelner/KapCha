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

#this includes other miscellaneous survey-related questions or variables
module SurveyOther
  include SurveyRandomizationSupport  

  Oppenheimer99MotivationCheck = {#this is the motivation question found in Oppenheimer et al, 2009
    :signature => 'motivation_gauge_oppenheimer_2009',
    :question_type => :demographic,
    :question_title => "Motivation Question",
    :question_text => "How motivated were you to complete this survey?<br/> (1 - not motivated at all, 9 - very motivated)",
    :response_type => :likert_scale,
    :other_response_params => {:likert_max_score => 9}
  }

  FeedbackQuestion = {
    :signature => 'feedback_question',
    :question_type => :feedback,
    :question_title => "Please share your thoughts<br/>#{FillInChars[0]}",
    :question_description => %Q|We are currently piloting this survey and would greatly appreciate any feedback you have.|,
    :question_text => %Q|What did you like most about this survey?<br/>What did you like least about this survey?<br/>Is there anything you would recommend to make it better?|,
    :response_type => :free_response_large,
    :other_response_params => {:needs_response => false},
    :randomization_text_switches => {
      :bonus => [
        {
          :zero => '',
          :one_cent => '$0.01 bonus for thoughtful answers',
          :five_cents => '$0.05 bonus for thoughtful answers'
        }
      ]
    }
  }

  KapChaSpeedQuestion = {
    :signature => 'kapcha_speed_question',
    :question_type => :feedback,
    :question_title => "Please share your thoughts<br/>#{FillInChars[0]}",
    :question_text => %Q|Certain respondents had to wait for each survey question to complete
      before filling in answers. We are especially interested in knowing how this affected how you
      took the survey. How did the time you had to wait compare to your natural reading speed?<br/>
      (If you don't think this question applies to you, write "N/A".)|,
    :response_type => :free_response_large,
    :other_response_params => {:needs_response => false},
    :randomization_text_switches => {
      :bonus => [
        {
          :zero => '',
          :one_cent => '$0.01 bonus for thoughtful answers',
          :five_cents => '$0.05 bonus for thoughtful answers'
        }
      ]
    }
  }
end
