require File.dirname(__FILE__) + '/../test_helper'

class BasesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:bases)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_base
    assert_difference('Base.count') do
      post :create, :base => { }
    end

    assert_redirected_to base_path(assigns(:base))
  end

  def test_should_show_base
    get :show, :id => bases(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => bases(:one).id
    assert_response :success
  end

  def test_should_update_base
    put :update, :id => bases(:one).id, :base => { }
    assert_redirected_to base_path(assigns(:base))
  end

  def test_should_destroy_base
    assert_difference('Base.count', -1) do
      delete :destroy, :id => bases(:one).id
    end

    assert_redirected_to bases_path
  end
end
