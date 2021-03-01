class User < ActiveRecord::Base
    has_many :notes
    has_many :loots
    has_secure_password
    validates_presence_of :username

end