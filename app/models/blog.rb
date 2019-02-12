class Blog < ApplicationRecord
  before_save {self.category = category.downcase}
  belongs_to :user
  VALID_CATEGORIES = %w[technology art economics life miscellaneous]

  validates :title, presence: true, length: {in: 6..25}
  validates :content, presence: true, length: {maximum: 255}
  validates :category, presence: true, inclusion: {in: VALID_CATEGORIES, message: "is not valid"}
  validates :public, inclusion: {in: [true, false], message: "must be true or false"}
end
