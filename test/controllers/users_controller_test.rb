require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user       = users(:michael)
    @other_user = users(:archer)
  end

  test "should get new" do
    get users_new_url
    assert_response :success
  end

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user), params: {
                                    user: { password: @other_user,
                                            password_confirmation: @other_user,
                                            admin: true } }
    assert_not @other_user.reload.admin?
  end
end
