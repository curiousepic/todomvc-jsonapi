class Api::V1::TodosController < ApplicationController

  def index
    @todos = Todo.all
    render json: @todos
  end

  def create
    @todo = Todo.new(todo_params)
    @todo.save!
    render json: [@todo], status: :created
  end

  def update
    @todo = Todo.find(params[:id])
    @todo.update!(todo_params)
    render json: [@todo]
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
  end

  private

  def todo_params
    params.permit(:title, :order, :completed)
  end
end