class Review < ApplicationRecord
  belongs_to :user

  def self.most_recent
    all.order(created_at: :desc).limit(6)
  end
end
