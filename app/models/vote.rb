class Vote < ActiveRecord::Base
  validates_uniqueness_of :email, :scope => :link_id, :message => "You can only vote on a link once." 
  validates_inclusion_of :total, :in => [-1, 1]
  
  belongs_to :user # A vote is cast by a user
  belongs_to :link # A vote is cast against a link
end
