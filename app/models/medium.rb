class Medium < ActiveRecord::Base
  attr_accessible :author, :category, :published_at, :publisher, :title, :unit_cost

  
  validates_presence_of :title
  validates_presence_of :publisher
  validates_presence_of :category
  validates :category, :inclusion => { :in => %w(Book Magazine Audiobook),
     :message => "%{value} is not a valid media type"}

  validates :title, :uniqueness => {:scope => :author, :case_sensitive => false, :message => "- An author can not have duplicate titles"}

  def price
    if category.eql?("Book")
      price = unit_cost + unit_cost*10/100
    elsif category.eql?("Audiobook")
       price = unit_cost + unit_cost*15/100
    else
       price = unit_cost + unit_cost*20/100
    end
    price
  end

end
