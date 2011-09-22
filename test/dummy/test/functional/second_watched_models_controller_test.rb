require 'test_helper'

class SecondWatchedModelsControllerTest < ActionController::TestCase
  setup do
    @second_watched_model = second_watched_models(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:second_watched_models)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create second_watched_model" do
    assert_difference('SecondWatchedModel.count') do
      post :create, second_watched_model: @second_watched_model.attributes
    end

    assert_redirected_to second_watched_model_path(assigns(:second_watched_model))
  end

  test "should show second_watched_model" do
    get :show, id: @second_watched_model.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @second_watched_model.to_param
    assert_response :success
  end

  test "should update second_watched_model" do
    put :update, id: @second_watched_model.to_param, second_watched_model: @second_watched_model.attributes
    assert_redirected_to second_watched_model_path(assigns(:second_watched_model))
  end

  test "should destroy second_watched_model" do
    assert_difference('SecondWatchedModel.count', -1) do
      delete :destroy, id: @second_watched_model.to_param
    end

    assert_redirected_to second_watched_models_path
  end
end
