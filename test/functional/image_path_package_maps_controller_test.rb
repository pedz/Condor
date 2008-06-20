require 'test_helper'

class ImagePathPackageMapsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:image_path_package_maps)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_image_path_package_map
    assert_difference('ImagePathPackageMap.count') do
      post :create, :image_path_package_map => { }
    end

    assert_redirected_to image_path_package_map_path(assigns(:image_path_package_map))
  end

  def test_should_show_image_path_package_map
    get :show, :id => image_path_package_maps(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => image_path_package_maps(:one).id
    assert_response :success
  end

  def test_should_update_image_path_package_map
    put :update, :id => image_path_package_maps(:one).id, :image_path_package_map => { }
    assert_redirected_to image_path_package_map_path(assigns(:image_path_package_map))
  end

  def test_should_destroy_image_path_package_map
    assert_difference('ImagePathPackageMap.count', -1) do
      delete :destroy, :id => image_path_package_maps(:one).id
    end

    assert_redirected_to image_path_package_maps_path
  end
end
