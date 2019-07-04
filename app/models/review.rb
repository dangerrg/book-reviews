class Review < ApplicationRecord
  belongs_to :user

  def self.most_recent
    all.order(created_at: :desc).limit(6)
  end

  def self.search(search_term)
    wildcard_filter = "%#{search_term}%"
    where('book_title LIKE ?', wildcard_filter).or(where('author LIKE ?', wildcard_filter))
  end
end
