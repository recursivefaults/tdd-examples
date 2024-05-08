
# Ruby doesn't have traditional interfaces so this is a way to create something similar
# This was created after doing TDD with SomeDB and wanting something more controllable and easier
class IDatabase

  def fetch_data
    raise "Not Implmeneted"
  end
end


# This represents a live DB I TDD'd this simple rapper for, but I cannot control its behavior
class SomeDB < IDatabase
  def initialize()
    @data = [2, 3, 5]
  end
  
  def fetch_data
    @data
  end
end

# A simple test double of SomeDB that behaves by contract but I can manipulate it as much as I need
class TestDB < IDatabase
  def initialize(test_data)
    @data = test_data
  end

  def fetch_data
    @data
  end
end
