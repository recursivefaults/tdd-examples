# Ok so what this really simple example is for is to show how things roughly might end after TDD near a boundary that
# includes a DB
#
# I started with testing with the Live (SomeDB) and after one or two tests needed to manipulate it so I refactored to
# create the interface. Then I ran tests to prove the interface's contract was real by removing the fetch_data method
# and watching an "Not Implemented" exception get raised.
#
# From here I created a TestDB and did the same thing with the interface and watching it fail. Then I refactored the
# tests back to use the test DB and get them to pass.
#
# I pushed my tests further with more cases now that I can control the DB with my double
#
# Then I wrote tests for SomeDB to prove my wrapper for it works
#
# At the end I have tests to prove my wrapper works and tests to prove my code works, so now I need one small test to
# prove they work together, and so I wrote my one integration test.

describe "An example using a database" do
  context "These tests started with testing against a Live(SomeDB) and then refactored out to a test double for speed and control" do
    it "should have a class with a method that gets data from the database" do
      db_class = ClassWithDB.new
      aggregate = db_class.aggregate_data(TestDB.new([2,3,5]))
      expect(aggregate).to eq(10)
    end

    it "should return 0 if there is no data to aggregate" do
      db_class = ClassWithDB.new
      aggregate = db_class.aggregate_data(TestDB.new([]))
      expect(aggregate).to eq(0)
    end

    it "should return 0 if the data is not numerical" do
      db_class = ClassWithDB.new
      aggregate = db_class.aggregate_data(TestDB.new(['a', 'b', 'c']))
      expect(aggregate).to eq(0)
    end

    it "should not work if there is no db" do
      db_class = ClassWithDB.new
      aggregate = db_class.aggregate_data(nil)
      expect(aggregate).to eq(nil)
    end
  end

  context "This test makes sure a real integration works" do
    it "should work with a real database" do
      db_class = ClassWithDB.new
      aggregate = db_class.aggregate_data(SomeDB.new)
      expect(aggregate).not_to be_nil
    end
  end
end

describe "the Database" do
  it "should have a fetch_data that returns data" do
    db = SomeDB.new
    data = db.fetch_data
    expect(data).not_to be_nil
  end
end
