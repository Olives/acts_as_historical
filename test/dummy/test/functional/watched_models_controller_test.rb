require 'test_helper'

class WatchedModelsControllerTest < ActionController::TestCase
  setup do
    @watched_model = watched_models(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:watched_models)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create watched_model" do
    assert_difference('WatchedModel.count') do
      post :create, watched_model: @watched_model.attributes
    end

    assert_redirected_to watched_model_path(assigns(:watched_model))
  end

  test "should show watched_model" do
    get :show, id: @watched_model.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @watched_model.to_param
    assert_response :success
  end

  test "should update watched_model" do
    put :update, id: @watched_model.to_param, watched_model: @watched_model.attributes
    assert_redirected_to watched_model_path(assigns(:watched_model))
  end

  test "should destroy watched_model" do
    assert_difference('WatchedModel.count', -1) do
      delete :destroy, id: @watched_model.to_param
    end

    assert_redirected_to watched_models_path
  end
end
