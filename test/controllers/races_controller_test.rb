require 'test_helper'

class RacesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @race = races(:one)
  end

  test "should get index" do
    get races_url
    assert_response :success
  end

  test "should get new" do
    get new_race_url
    assert_response :success
  end

  test "should create race" do
    assert_difference('Race.count') do
      post races_url, params: { race: { category: @race.category, category: @race.category, commission: @race.commission, compensation_start_amount: @race.compensation_start_amount, max_attendees: @race.max_attendees, name: @race.name, owner: @race.owner, min_pieces: @race.min_pieces, race_value: @race.race_value, recipients: @race.recipients } }
    end

    assert_redirected_to race_url(Race.last)
  end

  test "should show race" do
    get race_url(@race)
    assert_response :success
  end

  test "should get edit" do
    get edit_race_url(@race)
    assert_response :success
  end

  test "should update race" do
    patch race_url(@race), params: { race: { category: @race.category, category: @race.category, commission: @race.commission, compensation_start_amount: @race.compensation_start_amount, max_attendees: @race.max_attendees, name: @race.name, owner: @race.owner, min_pieces: @race.min_pieces, race_value: @race.race_value, recipients: @race.recipients } }
    assert_redirected_to race_url(@race)
  end

  test "should destroy race" do
    assert_difference('Race.count', -1) do
      delete race_url(@race)
    end

    assert_redirected_to races_url
  end
end
