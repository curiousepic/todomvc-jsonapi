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
      assert_equal Todo.count, json_response["todos"].count
      json_response["todos"].each do |hash|
        todo = Todo.find(hash["id"])
        assert_equal hash["title"], todo.title
        assert_equal hash["order"], todo.order
      end
    end
  end

  context "POST :create" do
    setup { post :create, {title: "new task", order: 1, completed: false } }
    setup {@todo = assigns(:todo)}
    should respond_with(:created)
    should "save a new todo" do
      assert @todo.persisted?
    end
    should "return the new todo" do
      assert_not_nil @todo.id
      assert_equal "new task", json_response["title"]
    end
  end

  context "PUT :update" do
    setup do
      @todo = todos(:one)
      put :update, {id: @todo.id, title: "New title"}
    end
    should respond_with(:ok)
    should "update todo" do
      @todo.reload
      assert_equal "New title", @todo.title
    end
    should "return updated todo" do
      assert_equal "New title", json_response["title"]
    end
  end

  context "DELETE :destroy" do
    setup do
      @todo = todos(:one)
    end
    should "delete todo" do
      assert_difference('Todo.count', -1) do
        delete :destroy, {id: @todo.id}
      end
    end
  end
end
