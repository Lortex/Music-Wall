class Song < ActiveRecord::Base
  belongs_to :user
  validates :title, presence: true, uniqueness: true
  validates :author, presence: true
end
