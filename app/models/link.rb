class Link < ActiveRecord::Base
  validates :url,   :presence => true
  validates :title, :presence => true

  belongs_to :user # A link is created by a user
  has_many :votes, :dependent => :destroy # A link can receive many votes by users
end
