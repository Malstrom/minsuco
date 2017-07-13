class Category < ApplicationRecord
  extend ActsAsTree::TreeView

  acts_as_tree order: 'name'

end
