require File.dirname(__FILE__) + '/../test_helper'

class LppBasesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:lpp_bases)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_lpp_base
    assert_difference('LppBase.count') do
      post :create, :lpp_base => { }
    end

    assert_redirected_to lpp_base_path(assigns(:lpp_base))
  end

  def test_should_show_lpp_base
    get :show, :id => lpp_bases(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => lpp_bases(:one).id
    assert_response :success
  end

  def test_should_update_lpp_base
    put :update, :id => lpp_bases(:one).id, :lpp_base => { }
    assert_redirected_to lpp_base_path(assigns(:lpp_base))
  end

  def test_should_destroy_lpp_base
    assert_difference('LppBase.count', -1) do
      delete :destroy, :id => lpp_bases(:one).id
    end

    assert_redirected_to lpp_bases_path
  end
end
