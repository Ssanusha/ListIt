require 'test_helper'

class SharesControllerTest < ActionController::TestCase
  setup do
    @share = shares(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shares)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create share" do
    assert_difference('Share.count') do
      post :create, share: { share_email: @share.share_email, share_name: @share.share_name, stores_id: @share.stores_id, stores_name: @share.stores_name, user_email: @share.user_email, user_id: @share.user_id, user_name: @share.user_name }
    end

    assert_redirected_to share_path(assigns(:share))
  end

  test "should show share" do
    get :show, id: @share
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @share
    assert_response :success
  end

  test "should update share" do
    put :update, id: @share, share: { share_email: @share.share_email, share_name: @share.share_name, stores_id: @share.stores_id, stores_name: @share.stores_name, user_email: @share.user_email, user_id: @share.user_id, user_name: @share.user_name }
    assert_redirected_to share_path(assigns(:share))
  end

  test "should destroy share" do
    assert_difference('Share.count', -1) do
      delete :destroy, id: @share
    end

    assert_redirected_to shares_path
  end
end
