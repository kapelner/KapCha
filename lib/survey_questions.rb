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

module SurveyQuestions
  include SurveyRandomizationSupport
  include SurveyDemographics
  include SurveyNeedForCognition
  include SurveyOther
  include SurveyTrueAndCheckQuestions
  include SurveyQuestionsPrivate

  #constants that deal with experimental versions
  CURRENT_EXPERIMENTAL_VERSION_NO = 5
  ExperimentalVersionsToShow = [5]

  #should we let the user know how many questions are left?
  #This is taken care of the view by text in the top right corner e.g. "4 / 20 total questions"
  ShowQuestionCounter = true
  #the background color of the survey
  #(either a common color name or "rgb(r,g,b)" for CSS, nil for default, white)
  BackgroundColor = "black"
  #the text color of the survey
  #(either a common color name or "rgb(r,g,b)" for CSS, nil for default, black)
  TextColor = "white"
  #the text color for the title
  #(either a common color name or "rgb(r,g,b)" for CSS, nil for default, the TextColor defined above)
  TitleColor = nil
  #Do we use the KapCha anti-satisficing technology for this survey?
  UseKapcha = true
  #Words per minute (WPM) for questions displayed utilizing the KapCha anti-satisficing
  #technology. The default of 250 was chosen from Taylor, 1965's study of average
  #reading speeds where this is the average for a high school student
  KapChaWordsPerMinute = 250
  #These are question types that are exempt from the Kapcha technology.
  #Not recommended to use unless you have a very good reason since the level of
  #seriousness will vary within the survey
  QuestionTypesExemptFromKapCha = [:demographic, :need_for_cognition, :feedback]

  #randomization parameters
  #
  #each thing we randomize on is a key-value pair in this hash
  #the key is its name, the value is a doublet array, the first element
  #is an array with the choices, the second array is their corresponding
  #probabilities which must add up to one. Make sure you place
  #fillers in the question parameters using FillInChars[0], FillInChars[1], etc.
  #for each and every random switch
  RandomizedTreatments = {
    :place => [[:run_down, :fancy], [0.5, 0.5]], #for soda question
    :ticket_price => [[:free, :paid], [0.5, 0.5]], #for football question
    :bonus => [[:zero, :one_cent, :five_cents], [1 / 3.to_f, 1 / 3.to_f, 1 / 3.to_f]]
  }



  #order of survey
  #Enter your choice of the following in the order you desire the respondent
  #to take the survey in:
  #a) TrueQuestions
  #b) CheckQuestions
  #c) DemographicQuestions
  #d) NeedForCognitionQuestions
  #-or- you can add individual questions (not recommended!)
  SurveyOrder = [
    TrueQuestions,
    CheckQuestions,
    DemographicQuestions,
    NeedForCognitionQuestions,
    Oppenheimer99MotivationCheck,
    FeedbackQuestion,
    KapChaSpeedQuestion
  ]

  #do not touch the following:
  AllQuestions = SurveyQuestions::SurveyOrder.flatten
  NumTotalQuestions = AllQuestions.length
end