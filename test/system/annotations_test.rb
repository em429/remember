require "application_system_test_case"

class AnnotationsTest < ApplicationSystemTestCase
  setup do
    @annotation = annotations(:one)
    @book = books(:one)
    @book_with_attachments = books(:with_attachments)
    
    # Login
    visit root_url
    fill_in 'Email', with: 'mary@test.com'
    fill_in 'Password', with: 'asdf1234'
    click_button "Log in"
    assert page.has_content? 'Profile' 
  end

  test "visiting the index" do
    visit annotations_url
    assert_selector "button", text: "more context"
  end

  test "should create annotation" do
    visit book_url(@book_with_attachments)
    
    # Import annotations
     attach_file('opf_file', "#{Rails.root}/test/fixtures/files/metadata.opf")
     click_button 'Import'
     assert page.has_content? 'By writing continuously, you force the edit-crazy part of your mind into a subordinate position'
     
     # Visit a single annotation
     first('.simple-card > a').click
     assert page.has_content? 'Book With Attachments by Rudolf Doe'
  end

end
