class Note < ActiveRecord::Base
    has_secure_password

    belongs_to :user
    
    validates_presence_of :name, :notes
end