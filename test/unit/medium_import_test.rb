require 'test_helper'

class MediumImportTest < ActiveSupport::TestCase
  setup do
    @file = upload = ActionDispatch::Http::UploadedFile.new({
        :filename => 'media.csv',
        :content_type => 'text/csv',
        :tempfile => File.new("#{Rails.root}/test/fixtures/files/media.csv")
      })
    @medium_import = MediumImport.new(:file => @file )
    # puts "*********************"
    # puts @medium_import.load_imported_media.inspect
  end
  
  test "should have imported media" do
    imported_media = @medium_import.imported_media
    assert_not_nil(imported_media)
  end
  
  test "should load medium" do
    medium = @medium_import.load_imported_media
    assert_equal(medium.first.title, "Good Code 3", "title did not match with csv file data")
  end
  
  test "should save medium" do
    assert(@medium_import.save)
  end
  
  test "should not save medium" do
    Medium.create({"author"=>"David Fu", "category"=>"Audiobook", "published_at"=>"2012-12-06", "publisher"=>"Pregmatic Book", "title"=>"Good Code 3", "unit_cost"=>"27.89"})
    assert(!@medium_import.save)
  end

end
