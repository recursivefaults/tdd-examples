class ClassWithDB
  def aggregate_data(database)
    return nil if database.nil?
    data = database.fetch_data()
    return 0 if data.empty?
    return 0 if data.find { |i| !i.is_a? Numeric }
    data.reduce(:+)
  end
end
