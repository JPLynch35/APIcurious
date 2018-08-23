class PersonalActivityPresenter
  def initialize(token)
    @service = GithubService.new(token)
  end

  def activities
    @service.personal_activity.map do |activity_data|
      Activity.new(activity_data)
    end
  end
end
