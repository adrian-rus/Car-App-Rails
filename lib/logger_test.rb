require_relative 'my_logger'

logger = MyLogger.instance
logger.logInformation("This is line one")
logger.logInformation("This is the second information")