require 'test_helper'

class Api::V1::TodosControllerTest < ActionController::TestCase

  def json_response
    JSON.parse(response.body)
  end

  context "GET :index" do
    setup { get :index }
    should respond_with(:ok)
    should "assign @todos" do
      assert_not_nil assigns(:todos)
    end
    should "return all todos in DB" do
      assert_equal Todo.count, json_response.count
      json_response.each do |hash|
        todo = Todo.find(hash["id"])
        assert_equal hash["title"], todo.title
        assert_equal hash["order"], todo.order
      end
    end
  end

  context "POST :create" do
    setup { post :create, {title: "new task", order: 1, completed: false } }
    should respond_with(:created)
    # should "save a new todo" do
    #
    # end
    should "return the new todo" do
      todo = assigns(:todo)
      assert todo.persisted?
      assert_not_nil todo.id
      assert_equal todo.title, json_response["title"]
    end
  end
end
