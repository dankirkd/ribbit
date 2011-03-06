class Vote < ActiveRecord::Base
  validates_uniqueness_of :user_id, :scope => :link_id, :message => "You can only vote on a link once."
  
  belongs_to :user # A vote is cast by a user
  belongs_to :link # A vote is cast against a link
end
