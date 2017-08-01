require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  test "should get readed" do
    get events_readed_url
    assert_response :success
  end

end
