class CoordinatorA
  attr_reader :was_called
  def initialize
    @was_called = false
  end

  def coordinate
    @was_called = true
  end
end

class Logger
  attr_reader :was_called
  def initialize
    @was_called = false
  end

  def log
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
    @logger.log()
    true
  end
end

describe "An example with a class that only coordinates" do
  it "should have a class that calls a coordination method" do
    some_coordinator = CoordinatorA.new
    some_logger = Logger.new
    worker = SomeWorker.new(some_coordinator, some_logger)
    did_work = worker.do_work
    expect(did_work).to eq(true)
  end

  it "should use other objects to coordinate" do
    some_coordinator = CoordinatorA.new
    some_logger = Logger.new
    worker = SomeWorker.new(some_coordinator, some_logger)
    did_work = worker.do_work
    expect(did_work).to eq(true)
    expect(some_coordinator.was_called).to eq(true)
  end

  it "should log things when it does work" do
    some_coordinator = CoordinatorA.new
    some_logger = Logger.new
    worker = SomeWorker.new(some_coordinator, some_logger)
    did_work = worker.do_work
    expect(did_work).to eq(true)
    expect(some_coordinator.was_called).to eq(true)
    expect(some_logger.was_called).to eq(true)
  end
  
end
