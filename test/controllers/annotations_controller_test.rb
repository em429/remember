require "test_helper"

# TODO: fix outdated tests, all failing now

class AnnotationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @annotation = FactoryBot.create(:annotation)
    @user = FactoryBot.create(:user)
    
    log_in_as(@user)
    assert_redirected_to @user
  end

  test "should get index" do
    get annotations_url
    
    assert_response :success
  end

  test "should show annotation" do
    get annotation_url(@annotation)
    assert_response :success
  end

  # TODO: add when annotation delete added
  # test "should destroy annotation" do
  #   assert_difference("Annotation.count", -1) do
  #     delete annotation_url(@annotation)
  #   end

  #   assert_redirected_to annotations_url
  # end
end
