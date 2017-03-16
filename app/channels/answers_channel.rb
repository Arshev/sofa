class AnswersChannel < ApplicationCable::Channel
  def follow(data)
    stream_from "answers_#{data['data']}"
  end
end