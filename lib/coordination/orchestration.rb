# This is the main result of doing TDD cycles, a simple testable object that lets me independently handle coordination
# efforts
class Orchestrator
  def initialize(coordinator, logger)
    @coordinator = coordinator
    @logger = logger
  end

  def orchestrate
    @coordinator.coordinate()
    @logger.coordinate()
  end
end


## These represent all the things that we're coordinating with in the worker.
class Coordinator
  def coordinate
    raise "Not Implemented"
  end
end



class CoordinatorA < Coordinator
  attr_reader :was_called
  def initialize
    @was_called = false
  end

  def coordinate
    @was_called = true
  end
end

class Logger < Coordinator
  attr_reader :was_called
  def initialize
    @was_called = false
  end

  def coordinate
    @was_called = true
  end
end

