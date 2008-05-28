require File.dirname(__FILE__) + '/../test_helper'

class FilesetsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:filesets)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_fileset
    assert_difference('Fileset.count') do
      post :create, :fileset => { }
    end

    assert_redirected_to fileset_path(assigns(:fileset))
  end

  def test_should_show_fileset
    get :show, :id => filesets(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => filesets(:one).id
    assert_response :success
  end

  def test_should_update_fileset
    put :update, :id => filesets(:one).id, :fileset => { }
    assert_redirected_to fileset_path(assigns(:fileset))
  end

  def test_should_destroy_fileset
    assert_difference('Fileset.count', -1) do
      delete :destroy, :id => filesets(:one).id
    end

    assert_redirected_to filesets_path
  end
end
