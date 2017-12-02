require 'test_helper'

class ApiControllerControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get api_controller_destroy_url
    assert_response :success
  end

end
