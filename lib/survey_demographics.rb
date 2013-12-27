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

module SurveyDemographics
  #These are demographic questions
  #Make sure to mark the :question_type as :demographic
  DemographicQuestions = [
    {
      :signature => 'dem_01_birth_year',
      :question_type => :demographic,
      :question_text => %Q|Which year were you born?|,
      :response_type => :free_response_small,
      :other_response_params => {
        :text_before_free_response => 19,
        :input_max_characters => 2
      },
    },
    {
      :signature => 'dem_02_gender',
      :question_type => :demographic,
      :question_text => %Q|Are you male or female?|,
      :response_type => :one_of_many,
      :response_choices => ['male', 'female']
    },
    {
      :signature => 'dem_03_education',
      :question_type => :demographic,
      :question_text => %Q|What is your level of education?|,
      :response_type => :one_of_many,
      :response_choices => [
        'Some High School',
        'High School Graduate',
        'Some college, no degree',
        'Associates degree',
        'Bachelors degree',
        'Graduate degree, Masters',
        'Graduate degree, Doctorate'
      ]
    },
    {
      :signature => 'dem_04_why_work_on_mturk',
      :question_type => :demographic,
      :question_text => %Q|Why do you complete tasks in Mechanical Turk? Please check any of the following that apply:|,
      :response_type => :multiple_of_many,
      :response_choices => [
        "Fruitful way to spend free time and get some cash (e.g., instead of watching TV)",
        %Q|For ''primary'' income purposes (e.g., gas, bills, groceries, credit cards)|,
        %Q|For ''secondary'' income purposes, pocket change (for hobbies, gadgets, going out)|,
        "To kill time",
        "I find the tasks to be fun",
        "I am currently unemployed, or have only a part time job"
      ]
    },
    {
      :signature => 'dem_05_earnings',
      :question_type => :demographic,
      :question_text => %Q|How much do you earn per week on Mechanical Turk?|,
      :response_type => :one_of_many,
      :response_choices => [
        'Less than $1 per week',
        '$1 - $5 per week',
        '$5 - $10 per week',
        '$10 - $20 per week',
        '$20 - $50 per week',
        '$50 - $100 per week',
        '$100 - $200 per week',
        '$200 - $500 per week',
        'More than $500 per week'
      ]
    },
    {
      :signature => 'dem_06_hours',
      :question_type => :demographic,
      :question_text => %Q|How much time do you spend per week on Mechanical Turk?|,
      :response_type => :one_of_many,
      :response_choices => [
        'Less than 1 hour per week',
        '1 - 2 hours per week',
        '2 - 4 hours per week',
        '4 - 8 hours per week',
        '8 - 20 hours per week',
        '20 - 40 hours per week',
        'More than 40 hours per week'
      ]
    },
    {
      :signature => 'dem_07_percent_surveys',
      :question_type => :demographic,
      :question_text => %Q|What percent of your time on MTurk do you spend answering surveys, polls, or questionnaires?|,
      :response_type => :one_of_many,
      :response_choices => [
        'Less than 20%',
        '20 - 40%',
        '40 - 60%',
        '60 - 80%',
        '80 - 100%'
      ]
    },
    {
      :signature => 'dem_08_multitasking',
      :question_type => :demographic,
      :question_text => %Q|Do you generally multi-task while doing HITs?|,
      :response_type => :one_of_many,
      :response_choices => [
        'No, I do not multi-task while doing HITs',
        'Yes, I multi-task; I sometimes do more than one HIT at once',
        'Yes, I multi-task; I do HITs while doing other activities (e.g., watching television, surfing the web, sitting at work)',
        'Yes, I multitask; I do more than one HIT at a time AND do other activities while doing HITs'
      ]
    }
  ]
end