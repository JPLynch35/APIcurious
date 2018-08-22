class ProfilePresenter
  def initialize(token)
    @service = GithubService.new(token)
  end

  def num_starred
    @service.call_starred_repos.map do |repo_data|
      Repository.new(repo_data)
    end.count
  end

  def followers
    @service.call_followers.map do |follower_data|
      GithubUser.new(follower_data)
    end
  end

  def following
    @service.call_following.map do |following_data|
      GithubUser.new(following_data)
    end
  end

  def repositories
    @service.all_repos.map do |repo_data|
      Repository.new(repo_data)
    end
  end
end
