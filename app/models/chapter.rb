class Chapter < ApplicationRecord
  belongs_to :subject
  has_many :contents
  has_many :exercises
end
