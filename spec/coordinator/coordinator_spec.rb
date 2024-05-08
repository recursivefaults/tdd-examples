class CoordinatorA
  attr_reader :was_called
  def initialize
    @was_called = false
  end

  def coordinate
    @was_called = true
  end
end

class SomeWorker
  def initialize(coordinator)
    @coordinator = coordinator
  end

  def do_work
    @coordinator.coordinate()
    true
  end
end

describe "An example with a class that only coordinates" do
  it "should have a class that calls a coordination method" do
    some_coordinator = CoordinatorA.new
    worker = SomeWorker.new(some_coordinator)
    did_work = worker.do_work
    expect(did_work).to eq(true)
  end

  it "should use other objects to coordinate" do
    some_coordinator = CoordinatorA.new
    worker = SomeWorker.new(some_coordinator)
    did_work = worker.do_work
    expect(did_work).to eq(true)
    expect(some_coordinator.was_called).to eq(true)
  end
  
end
