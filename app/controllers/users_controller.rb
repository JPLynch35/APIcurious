class UsersController < ApplicationController
  def show
    render file: 'public/404' unless current_user && current_user.id.to_s == params[:id]

    starred_repos_reponse = conn.get('starred')
    starred_repos = JSON.parse(starred_repos_reponse.body)
    @starred_repos_count = starred_repos.count

    followers_reponse = conn.get('followers')
    followers = JSON.parse(followers_reponse.body)
    @followers_count = followers.count

    following_reponse = conn.get('following')
    following = JSON.parse(following_reponse.body)
    @following_count = following.count
  end
end
