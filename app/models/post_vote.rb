class PostVote < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :post
  belongs_to :user

  attr_accessible :post_id
end