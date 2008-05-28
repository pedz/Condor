require File.dirname(__FILE__) + '/../test_helper'

class ServicePackFilesetMapsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:service_pack_fileset_maps)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_service_pack_fileset_map
    assert_difference('ServicePackFilesetMap.count') do
      post :create, :service_pack_fileset_map => { }
    end

    assert_redirected_to service_pack_fileset_map_path(assigns(:service_pack_fileset_map))
  end

  def test_should_show_service_pack_fileset_map
    get :show, :id => service_pack_fileset_maps(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => service_pack_fileset_maps(:one).id
    assert_response :success
  end

  def test_should_update_service_pack_fileset_map
    put :update, :id => service_pack_fileset_maps(:one).id, :service_pack_fileset_map => { }
    assert_redirected_to service_pack_fileset_map_path(assigns(:service_pack_fileset_map))
  end

  def test_should_destroy_service_pack_fileset_map
    assert_difference('ServicePackFilesetMap.count', -1) do
      delete :destroy, :id => service_pack_fileset_maps(:one).id
    end

    assert_redirected_to service_pack_fileset_maps_path
  end
end
