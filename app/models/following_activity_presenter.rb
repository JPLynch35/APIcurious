class FollowingActivityPresenter
  def initialize(token)
    @service = GithubService.new(token)
  end

  def activities
    @service.following_activity.map do |following|
      following.map do |activity_data|
        Activity.new(activity_data)
      end
    end
  end
end
