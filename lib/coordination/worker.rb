class SomeWorker
  def initialize(orchestrator)
    @orchestrator = orchestrator
  end

  def do_work
    @orchestrator.orchestrate()
  end
end
