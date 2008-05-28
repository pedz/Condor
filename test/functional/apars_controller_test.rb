require File.dirname(__FILE__) + '/../test_helper'

class AparsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:apars)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_apar
    assert_difference('Apar.count') do
      post :create, :apar => { }
    end

    assert_redirected_to apar_path(assigns(:apar))
  end

  def test_should_show_apar
    get :show, :id => apars(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => apars(:one).id
    assert_response :success
  end

  def test_should_update_apar
    put :update, :id => apars(:one).id, :apar => { }
    assert_redirected_to apar_path(assigns(:apar))
  end

  def test_should_destroy_apar
    assert_difference('Apar.count', -1) do
      delete :destroy, :id => apars(:one).id
    end

    assert_redirected_to apars_path
  end
end
