require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest

  def setup
    @title = "My first application"
  end

  test "should get new" do
    get signup_path
    assert_response :success
    assert_select "title", "Sign Up" + " | " + @title
  end

end
