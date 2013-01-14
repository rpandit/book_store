require 'test_helper'

class MediumTest < ActiveSupport::TestCase
  fixtures :media

  test "should not validate medium without attributes" do
    medium = Medium.new
    assert(!medium.valid?, "Medium with empty attributes")
  end
  
  test "should add 10 percentage category markups for book " do
    medium = Medium.new({:category => "Book",:unit_cost=>10})
    assert_equal(11,medium.price, "price was not unit_cost+10% for book");
  end
  
  test "should add 15 percentage category markups for audiobook " do
    medium = Medium.new({:category => "Audiobook",:unit_cost=>10})
    assert_equal(11.5,medium.price, "price was not unit_cost+15% for audiobook");
  end
  
  test "should add 20 percentage category markups for magazine " do
    medium = Medium.new({:category => "Magazine",:unit_cost=>10})
    assert_equal(12,medium.price, "price was not unit_cost+20% for magazine");
  end
  
  describe Medium do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:publisher) }
    it { should validate_presence_of(:category) }
    it { should_not validate_presence_of(:published_at) }
    it { should_not validate_presence_of(:unit_cost) }
    it { should_not allow_value("blah").for(:category) }
    it { should allow_value("Book").for(:category) }
    it { should allow_value("Audiobook").for(:category) }
    it { should allow_value("Magazine").for(:category) }
    it { should ensure_inclusion_of(:category).in_array(%w(Book Magazine Audiobook)) }
    it {  should validate_uniqueness_of(:title).scoped_to(:author).case_insensitive }
   end
end
