require 'test_helper'

class Git::RepositoriesControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  test "should redirect to user sign-in path if user is not authenticated" do
    get :index
    assert_redirected_to new_user_session_path
  end

  test "should redirect to root path if git token is not present" do
    sign_in users(:two)

    get :index
    assert_redirected_to root_path
  end
end
