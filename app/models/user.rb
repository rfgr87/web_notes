class User < ActiveRecord::Base
    has_secure_password
    
    has_many :notes
     
    validates_presence_of :name, :username, :email, :password_digest
    validates :email, uniqueness: true
    validates :username, uniqueness: true
end