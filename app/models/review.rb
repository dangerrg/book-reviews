class Review < ApplicationRecord
  validates :book_title, presence: true
  validates :author, length: { maximum:100 }, allow_blank: true

  belongs_to :user, optional: true
  
  def self.most_recent
    all.order(created_at: :desc).limit(6)
  end

  def self.search(search_term)
    wildcard_filter = "%#{search_term}%"
    where('book_title LIKE ?', wildcard_filter).or(where('author LIKE ?', wildcard_filter))
  end
end
