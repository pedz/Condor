require File.dirname(__FILE__) + '/../test_helper'

class PtfsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:ptfs)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_ptf
    assert_difference('Ptf.count') do
      post :create, :ptf => { }
    end

    assert_redirected_to ptf_path(assigns(:ptf))
  end

  def test_should_show_ptf
    get :show, :id => ptfs(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => ptfs(:one).id
    assert_response :success
  end

  def test_should_update_ptf
    put :update, :id => ptfs(:one).id, :ptf => { }
    assert_redirected_to ptf_path(assigns(:ptf))
  end

  def test_should_destroy_ptf
    assert_difference('Ptf.count', -1) do
      delete :destroy, :id => ptfs(:one).id
    end

    assert_redirected_to ptfs_path
  end
end
