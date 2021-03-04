class User < ActiveRecord::Base
    has_many :notes
    has_many :goods
    has_secure_password
    validates :username, presence: true, format: { with: /\A\w+\z/, message: "doesn't allow spaces or special characters" }, uniqueness: { case_sensitive: false }
end