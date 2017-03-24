require 'my_logger'

class CarObserver < ActiveRecord::Observer
    def after_update(record)
        #use the MyLogger instance method to retrieve the single instance
        @logger = MyLogger.instance
        
        #use the logger to log a message about the updated car
        @logger.logInformation("##############Observer Demo:#")
        @logger.logInformation("+++ CarObserver: The car of
            #{record.firstname} #{record.lastname}
            has been updated. cost #{record.cost}")
        @logger.logInformation("####################")
    end
end
