class Genre < ApplicationRecord
  belongs_to :post
  validates :name, presence: true, uniqueness: true
end
