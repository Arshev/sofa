# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  answersList = $('.answers')

  $('.edit-answer-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    answer_id = $(this).data('answerId')
    $('form#edit-answer-' + answer_id).show()

  App.cable.subscriptions.create('AnswersChannel', {
    connected: ->
      @perform 'follow', data: gon.question_id
    ,

    received: (data) -> 
      answersList.append(JST["templates/answer"](data))
  })