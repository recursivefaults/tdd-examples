class SomeWorker
  def do_work
    false
  end
end

describe "An example with a class that only coordinates" do
  it "should have a class that calls a coordination method" do
    worker = SomeWorker.new
    did_work = worker.do_work
    
    expect(did_work).to be_true
  end
  
end
