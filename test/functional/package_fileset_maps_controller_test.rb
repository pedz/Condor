require 'test_helper'

class PackageFilesetMapsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:package_fileset_maps)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_package_fileset_map
    assert_difference('PackageFilesetMap.count') do
      post :create, :package_fileset_map => { }
    end

    assert_redirected_to package_fileset_map_path(assigns(:package_fileset_map))
  end

  def test_should_show_package_fileset_map
    get :show, :id => package_fileset_maps(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => package_fileset_maps(:one).id
    assert_response :success
  end

  def test_should_update_package_fileset_map
    put :update, :id => package_fileset_maps(:one).id, :package_fileset_map => { }
    assert_redirected_to package_fileset_map_path(assigns(:package_fileset_map))
  end

  def test_should_destroy_package_fileset_map
    assert_difference('PackageFilesetMap.count', -1) do
      delete :destroy, :id => package_fileset_maps(:one).id
    end

    assert_redirected_to package_fileset_maps_path
  end
end
