class Car < ActiveRecord::Base
    
    def self.search(search_for)
        Car.where("lastname = ?", search_for)
    end
end
