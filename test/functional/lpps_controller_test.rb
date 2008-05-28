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

  def test_should_create_lpps
    assert_difference('Lpps.count') do
      post :create, :lpps => { }
    end

    assert_redirected_to lpps_path(assigns(:lpps))
  end

  def test_should_show_lpps
    get :show, :id => lpps(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => lpps(:one).id
    assert_response :success
  end

  def test_should_update_lpps
    put :update, :id => lpps(:one).id, :lpps => { }
    assert_redirected_to lpps_path(assigns(:lpps))
  end

  def test_should_destroy_lpps
    assert_difference('Lpps.count', -1) do
      delete :destroy, :id => lpps(:one).id
    end

    assert_redirected_to lpps_path
  end
end
