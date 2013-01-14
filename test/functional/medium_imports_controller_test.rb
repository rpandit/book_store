require 'test_helper'

class MediumImportsControllerTest < ActionController::TestCase
   setup do
    @medium = Medium.new(author: "b", category: "Book", published_at: 2013-01-11, publisher: "PDF publisher", title: "title", unit_cost: 10 )
  end
  
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create medium" do
    assert_difference('Medium.count') do
      upload = ActionDispatch::Http::UploadedFile.new({
        :filename => 'media.csv',
        :content_type => 'text/csv',
        :tempfile => File.new("#{Rails.root}/test/fixtures/files/media.csv")
      })

      post :create, :post => { :file => upload}
 
    end

    assert_redirected_to media_path
  end

end
