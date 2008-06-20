require 'test_helper'

class AixFilesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:aix_files)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_aix_file
    assert_difference('AixFile.count') do
      post :create, :aix_file => { }
    end

    assert_redirected_to aix_file_path(assigns(:aix_file))
  end

  def test_should_show_aix_file
    get :show, :id => aix_files(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => aix_files(:one).id
    assert_response :success
  end

  def test_should_update_aix_file
    put :update, :id => aix_files(:one).id, :aix_file => { }
    assert_redirected_to aix_file_path(assigns(:aix_file))
  end

  def test_should_destroy_aix_file
    assert_difference('AixFile.count', -1) do
      delete :destroy, :id => aix_files(:one).id
    end

    assert_redirected_to aix_files_path
  end
end
