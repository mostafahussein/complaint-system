require 'test_helper'

class KbsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
