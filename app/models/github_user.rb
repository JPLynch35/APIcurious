class GithubUser
  attr_reader :name

  def initialize(data_set)
    @name = data_set[:login]
  end
end
