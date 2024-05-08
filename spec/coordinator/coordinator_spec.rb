

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

class SomeWorker
  def initialize(coordinator, logger)
    @coordinator = coordinator
    @logger = logger
  end

  def do_work
    @coordinator.coordinate()
    @logger.coordinate()
  end
end

describe "An example with a class that only coordinates" do
  it "should use other objects to coordinate" do
    some_coordinator = CoordinatorA.new
    some_logger = Logger.new
    worker = SomeWorker.new(some_coordinator, some_logger)
    did_work = worker.do_work
    expect(some_coordinator.was_called).to eq(true)
  end

  it "should log things when it does work" do
    some_coordinator = CoordinatorA.new
    some_logger = Logger.new
    worker = SomeWorker.new(some_coordinator, some_logger)
    did_work = worker.do_work
    expect(some_logger.was_called).to eq(true)
  end
  
end
