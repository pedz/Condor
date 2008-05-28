require File.dirname(__FILE__) + '/../test_helper'

class AparPtfMapsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:apar_ptf_maps)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_apar_ptf_map
    assert_difference('AparPtfMap.count') do
      post :create, :apar_ptf_map => { }
    end

    assert_redirected_to apar_ptf_map_path(assigns(:apar_ptf_map))
  end

  def test_should_show_apar_ptf_map
    get :show, :id => apar_ptf_maps(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => apar_ptf_maps(:one).id
    assert_response :success
  end

  def test_should_update_apar_ptf_map
    put :update, :id => apar_ptf_maps(:one).id, :apar_ptf_map => { }
    assert_redirected_to apar_ptf_map_path(assigns(:apar_ptf_map))
  end

  def test_should_destroy_apar_ptf_map
    assert_difference('AparPtfMap.count', -1) do
      delete :destroy, :id => apar_ptf_maps(:one).id
    end

    assert_redirected_to apar_ptf_maps_path
  end
end
