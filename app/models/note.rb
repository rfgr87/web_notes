class Note < ActiveRecord::Base

    belongs_to :user
    
    validates_presence_of :name, :notes
end