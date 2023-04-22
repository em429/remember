require "test_helper"

class AnnotationTest < ActiveSupport::TestCase
  def setup
    @annotation = FactoryBot.create(:annotation) 
  end

  test 'should not create annotation with all fields blank' do
    a = Annotation.new
    assert_not a.save, "Saved annotation with all fields blank"
  end

  test 'should create annotation' do
    assert @annotation.valid?
  end
  
  test 'should not create annotation with blank highlight' do
    assert_not FactoryBot.build(:annotation, :without_highlight).valid?
  end
  
end
