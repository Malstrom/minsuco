class Commission < ApplicationRecord
  belongs_to :race

  scope :first_year,   -> { find_by_starts(0) }
end
