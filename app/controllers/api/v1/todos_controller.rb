class Api::V1::TodosController < ApplicationController

  def index
    @todos = Todo.all
    render json: @todos, root: false
  end

  def create
    @todo = Todo.new(todo_params)
    @todo.save!
    render json: @todo, status: :created
  end

  private

  def todo_params
    params.permit(:title, :order, :completed)
  end
end
