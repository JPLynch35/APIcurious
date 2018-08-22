class GithubService
  def initialize(token)
    @token = token
  end

  def call_starred_repos
    @starred_repos ||= get_json('/user/starred')
  end

  def call_followers
    @github_user_followers ||= get_json('/user/followers')
  end

  def call_following
    @github_user_following ||= get_json('/user/following')
  end

  def all_repos
    @repos ||= get_json('/user/repos?sort=created&per_page=100')
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
