class ApiController < ApplicationController
  def lessons
    render json: Lesson.all
  end
end
