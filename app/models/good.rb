class Good < ActiveRecord::Base
    belongs_to :user
    validates :name, :quantity, presence: true
    validates_numericality_of :quantity, only_integer: true
end