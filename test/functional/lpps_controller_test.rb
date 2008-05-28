require File.dirname(__FILE__) + '/../test_helper'

class LppsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:lpps)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_lpp
    assert_difference('Lpp.count') do
      post :create, :lpp => { }
    end

    assert_redirected_to lpp_path(assigns(:lpp))
  end

  def test_should_show_lpp
    get :show, :id => lpps(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => lpps(:one).id
    assert_response :success
  end

  def test_should_update_lpp
    put :update, :id => lpps(:one).id, :lpp => { }
    assert_redirected_to lpp_path(assigns(:lpp))
  end

  def test_should_destroy_lpp
    assert_difference('Lpp.count', -1) do
      delete :destroy, :id => lpps(:one).id
    end

    assert_redirected_to lpps_path
  end
end
