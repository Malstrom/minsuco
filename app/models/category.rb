class Category < ApplicationRecord
  extend ActsAsTree::TreeView

  acts_as_tree order: 'name'

  has_many :races
  has_many :attendees
end
