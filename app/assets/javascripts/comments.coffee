# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  answerComments = $('.answer-comments')
  questionComments = $('.question-comments')

  App.cable.subscriptions.create('CommentsChannel', {
    connected: ->
      @perform 'subscribed'
    ,

    received: (data) -> 
      if data.commentable_type == 'Answer' && data.user_id != gon.user_id
        answerComments.append(JST["templates/comment"](data))
      if data.commentable_type == 'Question' && data.user_id != gon.user_id
        questionComments.append(JST["templates/comment"](data))
  })