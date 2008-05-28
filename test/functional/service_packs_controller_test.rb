require File.dirname(__FILE__) + '/../test_helper'

class ServicePacksControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:service_packs)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_service_pack
    assert_difference('ServicePack.count') do
      post :create, :service_pack => { }
    end

    assert_redirected_to service_pack_path(assigns(:service_pack))
  end

  def test_should_show_service_pack
    get :show, :id => service_packs(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => service_packs(:one).id
    assert_response :success
  end

  def test_should_update_service_pack
    put :update, :id => service_packs(:one).id, :service_pack => { }
    assert_redirected_to service_pack_path(assigns(:service_pack))
  end

  def test_should_destroy_service_pack
    assert_difference('ServicePack.count', -1) do
      delete :destroy, :id => service_packs(:one).id
    end

    assert_redirected_to service_packs_path
  end
end
