require "test_helper"

class AnnotationTest < ActiveSupport::TestCase
  test 'should not create blak annotation' do
    a = Annotation.new
    assert_not a.save, "Saved annotation with all fields blank"
  end

  test 'should create annotation' do
    assert Annotation.create!(
      highlighted_text: "test",
      notes: "",
      start_cfi: "",
      end_cfi: "",
      timestamp: "2022-12-14",
      # toc_family_titles: JSON.generate(annotation_hash['toc_family_titles']),
      toc_family_titles: "",
      book_id: books(:one).id
    ), "Couldn't create annotation"
  end
  
  test 'should not create annotation with blank highlight' do
    assert_not Annotation.create!(
      highlighted_text: "",
      notes: "",
      start_cfi: "",
      end_cfi: "",
      timestamp: "2022-12-14",
      # toc_family_titles: JSON.generate(annotation_hash['toc_family_titles']),
      toc_family_titles: "",
      book_id: books(:one).id
    ), "Created annotation with blank highlight"
  end


  
end
