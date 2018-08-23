class Activity
  attr_reader :project, :time, :commits

  def initialize(data_set)
    @project    = data_set[0]
    @time    = data_set[1]
    @commits    = data_set[2]
  end
end
