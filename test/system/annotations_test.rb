require "application_system_test_case"
require 'converters'

class AnnotationsTest < ApplicationSystemTestCase
  setup do
    @user = FactoryBot.create(:user)
    genius_book_path = "#{Rails.root}/test/factories/files/genius/book.epub"
    @genius = FactoryBot.create(:book,
      user: @user,
      epub_path: genius_book_path,
      plaintext: epub_to_plaintext(genius_book_path),
      cover_path: "#{Rails.root}/test/factories/files/genius/cover.jpg",
    )
    @unmatched_annotation = FactoryBot.create(:annotation, book: @genius)
    
    capybara_log_in_as(@user)
  end

  test "visiting the index" do
    visit annotations_url
    assert_selector "button", text: "more context"
  end

  test "should import annotations" do
    visit book_url(@genius)
    
    # Import annotations
     attach_file('opf_file', "#{Rails.root}/test/factories/files/genius/metadata.opf")
     click_button 'Import'
     assert page.has_content? 'By writing continuously, you force the edit-crazy part of your mind into a subordinate position'
     
     # Visit a single annotation
     first('.simple-card > a').click
     assert page.has_content? "#{@genius.title} by #{@genius.author}"
  end

end
