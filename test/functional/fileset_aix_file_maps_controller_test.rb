require 'test_helper'

class FilesetAixFileMapsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:fileset_aix_file_maps)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_fileset_aix_file_map
    assert_difference('FilesetAixFileMap.count') do
      post :create, :fileset_aix_file_map => { }
    end

    assert_redirected_to fileset_aix_file_map_path(assigns(:fileset_aix_file_map))
  end

  def test_should_show_fileset_aix_file_map
    get :show, :id => fileset_aix_file_maps(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => fileset_aix_file_maps(:one).id
    assert_response :success
  end

  def test_should_update_fileset_aix_file_map
    put :update, :id => fileset_aix_file_maps(:one).id, :fileset_aix_file_map => { }
    assert_redirected_to fileset_aix_file_map_path(assigns(:fileset_aix_file_map))
  end

  def test_should_destroy_fileset_aix_file_map
    assert_difference('FilesetAixFileMap.count', -1) do
      delete :destroy, :id => fileset_aix_file_maps(:one).id
    end

    assert_redirected_to fileset_aix_file_maps_path
  end
end
