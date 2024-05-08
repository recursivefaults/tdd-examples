require 'coordination/worker'
require 'coordination/orchestration'

class TestOrchestrator < Orchestrator
  attr_reader :was_called
  def initialize
    @was_called = false
  end

  def orchestrate
    @was_called = true
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
