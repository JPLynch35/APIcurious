class GithubService
  def initialize(token)
    @token = token
  end

  def call_starred_repos
    @starred_repo_data ||= get_json('/user/starred')
  end

  def call_followers
    @github_followers_data ||= get_json('/user/followers')
  end

  def call_following
    @github_following_data ||= get_json('/user/following')
  end

  def call_organizations
    @organization_data ||= get_json('/user/orgs')
  end

  def all_repos
    @repos ||= get_json('/user/repos?sort=created&per_page=100')
  end

  def personal_login
    @user_response ||= get_json('/user')
    @user_response[:login]
  end

  def call_personal_activity
    @personal_activity ||= get_json("/users/#{personal_login}/events")
  end

  def personal_activity
    call_personal_activity.map do |event|
      if event[:payload][:commits] && event[:actor][:login] == personal_login
        [event[:repo][:name], event[:created_at],
        event[:payload][:commits].map do |commit|
          commit[:message]
        end
        ]
      end
    end.compact
  end

  private
  
  def conn
    Faraday.new(url: 'https://api.github.com') do |faraday|
      faraday.headers['Authorization'] = "token #{@token}"
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    JSON.parse(conn.get(url).body, symbolize_names: true)
  end
end
