require 'test_helper'

class CmvcsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cmvcs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cmvc" do
    assert_difference('Cmvc.count') do
      post :create, :cmvc => { }
    end

    assert_redirected_to cmvc_path(assigns(:cmvc))
  end

  test "should show cmvc" do
    get :show, :id => cmvcs(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => cmvcs(:one).to_param
    assert_response :success
  end

  test "should update cmvc" do
    put :update, :id => cmvcs(:one).to_param, :cmvc => { }
    assert_redirected_to cmvc_path(assigns(:cmvc))
  end

  test "should destroy cmvc" do
    assert_difference('Cmvc.count', -1) do
      delete :destroy, :id => cmvcs(:one).to_param
    end

    assert_redirected_to cmvcs_path
  end
end
