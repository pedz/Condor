require File.dirname(__FILE__) + '/../test_helper'

class DefectReleaseMapsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:defect_release_maps)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_defect_release_map
    assert_difference('DefectReleaseMap.count') do
      post :create, :defect_release_map => { }
    end

    assert_redirected_to defect_release_map_path(assigns(:defect_release_map))
  end

  def test_should_show_defect_release_map
    get :show, :id => defect_release_maps(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => defect_release_maps(:one).id
    assert_response :success
  end

  def test_should_update_defect_release_map
    put :update, :id => defect_release_maps(:one).id, :defect_release_map => { }
    assert_redirected_to defect_release_map_path(assigns(:defect_release_map))
  end

  def test_should_destroy_defect_release_map
    assert_difference('DefectReleaseMap.count', -1) do
      delete :destroy, :id => defect_release_maps(:one).id
    end

    assert_redirected_to defect_release_maps_path
  end
end
