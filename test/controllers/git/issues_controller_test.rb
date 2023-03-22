# frozen_string_literal: true

require 'test_helper'

class Git::IssuesControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  # Test case for successful issue creation
  test "should create issue successfully" do
    sign_in users(:one)

    post :create, params: {
      git_username: "kunal-bluebash",
      repo_name: "githubtest",
      title: "Test",
      description: "Issue description"
    }

    assert_redirected_to repositories_path
    assert_equal 'Issue created on github successfully', flash[:success]
  end

  # Test case for missing github token
  test "should redirect to root when github token is missing" do
    sign_in users(:two)

    post :create, params: {
      git_username: "kunal-bluebash",
      repo_name: "githubtest",
      title: "Test",
      description: "Issue description"
    }

    assert_redirected_to root_path
    assert_equal 'Please add your github token', flash[:danger]
  end
end
