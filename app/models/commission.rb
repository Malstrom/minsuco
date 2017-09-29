class Commission < ApplicationRecord
  belongs_to :race

  scope :first_year,   -> { order('starts ASC').first }
end
