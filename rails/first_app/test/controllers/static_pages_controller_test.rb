require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @title = "My first application"
  end

  test "should get root" do
    get '/'
    assert_response :success
    assert_select "title", @title
  end

=begin
  test "should get home" do
    #get static_pages_home_url
    get home_path #home_path - /home ; home_url - full url
    assert_response :success
    assert_select "title", @title
  end
=end

  test "should get help" do
    #get static_pages_help_url
    get help_path
    assert_response :success
    assert_select "title", "Help" + " | " + @title
  end

  test "should get about" do
    #get static_pages_about_url
    get about_path
    assert_response :success
    assert_select "title", "About" + " | " + @title
  end

  test "should get contact" do
    #get static_pages_contact_url
    get contact_path
    assert_response :success
    assert_select "title", "Contact" + " | " + @title
  end
end
