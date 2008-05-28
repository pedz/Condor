require File.dirname(__FILE__) + '/../test_helper'

class DefectsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:defects)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_defect
    assert_difference('Defect.count') do
      post :create, :defect => { }
    end

    assert_redirected_to defect_path(assigns(:defect))
  end

  def test_should_show_defect
    get :show, :id => defects(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => defects(:one).id
    assert_response :success
  end

  def test_should_update_defect
    put :update, :id => defects(:one).id, :defect => { }
    assert_redirected_to defect_path(assigns(:defect))
  end

  def test_should_destroy_defect
    assert_difference('Defect.count', -1) do
      delete :destroy, :id => defects(:one).id
    end

    assert_redirected_to defects_path
  end
end
