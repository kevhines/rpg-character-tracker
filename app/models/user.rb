class User < ActiveRecord::Base
    has_one :character
end