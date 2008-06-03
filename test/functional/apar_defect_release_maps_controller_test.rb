require File.dirname(__FILE__) + '/../test_helper'

class AparDefectReleaseMapsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:apar_defect_release_maps)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_apar_defect_release_map
    assert_difference('AparDefectReleaseMap.count') do
      post :create, :apar_defect_release_map => { }
    end

    assert_redirected_to apar_defect_release_map_path(assigns(:apar_defect_release_map))
  end

  def test_should_show_apar_defect_release_map
    get :show, :id => apar_defect_release_maps(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => apar_defect_release_maps(:one).id
    assert_response :success
  end

  def test_should_update_apar_defect_release_map
    put :update, :id => apar_defect_release_maps(:one).id, :apar_defect_release_map => { }
    assert_redirected_to apar_defect_release_map_path(assigns(:apar_defect_release_map))
  end

  def test_should_destroy_apar_defect_release_map
    assert_difference('AparDefectReleaseMap.count', -1) do
      delete :destroy, :id => apar_defect_release_maps(:one).id
    end

    assert_redirected_to apar_defect_release_maps_path
  end
end
