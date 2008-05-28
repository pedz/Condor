require File.dirname(__FILE__) + '/../test_helper'

class FilesetPtfMapsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:fileset_ptf_maps)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_fileset_ptf_map
    assert_difference('FilesetPtfMap.count') do
      post :create, :fileset_ptf_map => { }
    end

    assert_redirected_to fileset_ptf_map_path(assigns(:fileset_ptf_map))
  end

  def test_should_show_fileset_ptf_map
    get :show, :id => fileset_ptf_maps(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => fileset_ptf_maps(:one).id
    assert_response :success
  end

  def test_should_update_fileset_ptf_map
    put :update, :id => fileset_ptf_maps(:one).id, :fileset_ptf_map => { }
    assert_redirected_to fileset_ptf_map_path(assigns(:fileset_ptf_map))
  end

  def test_should_destroy_fileset_ptf_map
    assert_difference('FilesetPtfMap.count', -1) do
      delete :destroy, :id => fileset_ptf_maps(:one).id
    end

    assert_redirected_to fileset_ptf_maps_path
  end
end
