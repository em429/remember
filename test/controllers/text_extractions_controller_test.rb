require "test_helper"

class TextExtractionsControllerTest < ActionDispatch::IntegrationTest
  test "should get start" do
    get text_extractions_start_url
    assert_response :success
  end
end
