require 'test_helper'

class ImagePathsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:image_paths)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_image_path
    assert_difference('ImagePath.count') do
      post :create, :image_path => { }
    end

    assert_redirected_to image_path_path(assigns(:image_path))
  end

  def test_should_show_image_path
    get :show, :id => image_paths(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => image_paths(:one).id
    assert_response :success
  end

  def test_should_update_image_path
    put :update, :id => image_paths(:one).id, :image_path => { }
    assert_redirected_to image_path_path(assigns(:image_path))
  end

  def test_should_destroy_image_path
    assert_difference('ImagePath.count', -1) do
      delete :destroy, :id => image_paths(:one).id
    end

    assert_redirected_to image_paths_path
  end
end
