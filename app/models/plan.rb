class Plan < ApplicationRecord
    include Payola::Plan

    has_many :users

end
