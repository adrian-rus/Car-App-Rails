# the concrete component we would like to decorate, a car in our example
class BasicCar
    def initialize(c, m, color)
        @cost = c
        @model = m
        @color = color
        @description = "basic car"
    end
    
    # getter method
    def cost 
        return @cost
    end
    
    # a method which returns a string representation of the object of type BasicCar
    def details
        return @description + "; " + @model + "; " + @color + ": " + "#{@cost}"
    end
    
    # getter method
    def color
        return @color
    end
    
    # getter method
    def model 
        return @model
    end
    
end # ends the BasicCar class



# decorator class -- this serves as the superclass for all the concrete decorators
# the base/super class decorator (i.e. no actual decoration yet), each concrete decorator (i.e. subclass) will add its own decoration
class CarDecorator < BasicCar
    def initialize(basic_car)
        #basic_car is a real car, i.e. the component we want to decorate
        @basic_car = basic_car
        super(@basic_car.cost, @basic_car.model, @basic_car.color)
        @extra_cost = 0
        @description = "no extra feature"
    end
    
    # override the cost method to include the cost of the extra feature	
    def cost        
        return @extra_cost + @basic_car.cost
    end
    
    # override the details method to include the description of the extra feature
    def details
        return  @description + ": " + "#{@extra_cost}" + ". " + @basic_car.details
    end
    
end # ends the CarDecorator class


# a concrete decorator --  define an extra feature
class MirrorDecorator < CarDecorator
    def initialize(basic_car)
        super(basic_car)
        @extra_cost = 200
        @description = "anti glare rear view mirror"
    end
    
end # ends the MirrorDecorator class


# another concrete decorator -- define an extra feature
class ElectricWindowsDecorator < CarDecorator
    def initialize(basic_car)
        super(basic_car)
        @extra_cost = 500
        @description = "electric windows"
    end
    
end # ends the ElectricWindowsDecorator class


# another concrete decorator -- define an extra feature
class ParkingSensorDecorator < CarDecorator
    def initialize(basic_car)
        super(basic_car)
        @extra_cost = 800
        @description = "parking sensor"
    end
    
end # ends the ParkingSensorDecorator class


