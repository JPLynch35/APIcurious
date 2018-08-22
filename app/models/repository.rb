class Repository
  attr_reader :title

  def initialize(data_set)
    @title = data_set[:name]
  end
end
