require 'test_helper'

class DependentModelsControllerTest < ActionController::TestCase
  setup do
    @dependent_model = dependent_models(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dependent_models)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dependent_model" do
    assert_difference('DependentModel.count') do
      post :create, dependent_model: @dependent_model.attributes
    end

    assert_redirected_to dependent_model_path(assigns(:dependent_model))
  end

  test "should show dependent_model" do
    get :show, id: @dependent_model.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dependent_model.to_param
    assert_response :success
  end

  test "should update dependent_model" do
    put :update, id: @dependent_model.to_param, dependent_model: @dependent_model.attributes
    assert_redirected_to dependent_model_path(assigns(:dependent_model))
  end

  test "should destroy dependent_model" do
    assert_difference('DependentModel.count', -1) do
      delete :destroy, id: @dependent_model.to_param
    end

    assert_redirected_to dependent_models_path
  end
end
