require 'test_helper'

class ApiControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get api_destroy_url
    assert_response :success
  end

end
