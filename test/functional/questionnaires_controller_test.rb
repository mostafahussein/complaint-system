require 'test_helper'

class QuestionnairesControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

end
