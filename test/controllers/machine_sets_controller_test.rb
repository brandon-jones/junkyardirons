require 'test_helper'

class MachineSetsControllerTest < ActionController::TestCase
  setup do
    @machine_set = machine_sets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:machine_sets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create machine_set" do
    assert_difference('MachineSet.count') do
      post :create, machine_set: { description: @machine_set.description, image_url: @machine_set.image_url, price: @machine_set.price, quantity: @machine_set.quantity, title: @machine_set.title }
    end

    assert_redirected_to machine_set_path(assigns(:machine_set))
  end

  test "should show machine_set" do
    get :show, id: @machine_set
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @machine_set
    assert_response :success
  end

  test "should update machine_set" do
    patch :update, id: @machine_set, machine_set: { description: @machine_set.description, image_url: @machine_set.image_url, price: @machine_set.price, quantity: @machine_set.quantity, title: @machine_set.title }
    assert_redirected_to machine_set_path(assigns(:machine_set))
  end

  test "should destroy machine_set" do
    assert_difference('MachineSet.count', -1) do
      delete :destroy, id: @machine_set
    end

    assert_redirected_to machine_sets_path
  end
end
