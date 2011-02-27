class Vote < ActiveRecord::Base
  has_one :user
  belongs_to :link
end
