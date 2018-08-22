class UsersController < ApplicationController
  def show
    render file: 'public/404' unless current_user && current_user.id.to_s == params[:id]

    starred_repos_reponse = conn.get('user/starred')
    starred_repos = JSON.parse(starred_repos_reponse.body, symbolize_names: true)
    @starred_repos_count = starred_repos.count

    followers_response = JSON.parse(conn.get('user/followers').body, symbolize_names: true)
    @followers = followers_response.map do |follower|
      follower[:login]
    end

    following_reponse = JSON.parse(conn.get('user/following').body, symbolize_names: true)
    @followings = following_reponse.map do |following|
      following[:login]
    end

    organization_response = JSON.parse(conn.get('user/orgs').body, symbolize_names: true)
    @organizations = organization_response.map do |organization|
      organization[:login]
    end

    repository_response = JSON.parse(conn.get('user/repos?sort=created&per_page=100').body, symbolize_names: true)
    @repositories = repository_response.map do |repository|
      repository[:name]
    end
  end
end
