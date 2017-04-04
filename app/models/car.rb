class Car < ActiveRecord::Base
    def self.search(search_for)
        Car.where("lower(lastname) = ?", search_for.downcase)
    end
end
