

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

class TestOrchestrator < Orchestrator
  attr_reader :was_called
  def initialize
    @was_called = false
  end

  def orchestrate
    @was_called = true
  end
end

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
  def initialize(orchestrator)
    @orchestrator = orchestrator
  end

  def do_work
    @orchestrator.orchestrate()
  end
end

describe "An example with a class that only coordinates" do

  it "should use other objects to coordinate" do
    orchestrator = TestOrchestrator.new
    worker = SomeWorker.new(orchestrator)
    did_work = worker.do_work
    expect(orchestrator.was_called).to eq(true)
  end
end

describe "Orchestrator" do
  it "coordinates across its components" do
    some_coordinator = CoordinatorA.new
    some_logger = Logger.new
    orchestrator = Orchestrator.new(some_coordinator, some_logger)
    orchestrator.orchestrate()
    expect(some_coordinator.was_called).to eq(true)
    expect(some_logger.was_called).to eq(true)
  end
end
