class UsersController < ApplicationController
  def show
    render file: 'public/404' unless current_user && current_user.id.to_s == params[:id]

    @profile = ProfilePresenter.new(current_user.token)

    # starred_repos_reponse = conn.get('user/starred')
    # starred_repos = JSON.parse(starred_repos_reponse.body, symbolize_names: true)
    # @starred_repos_count = starred_repos.count

    organization_response = JSON.parse(conn.get('user/orgs').body, symbolize_names: true)
    @organizations = organization_response.map do |organization|
      organization[:login]
    end

    # repository_response = JSON.parse(conn.get('user/repos?sort=created&per_page=100').body, symbolize_names: true)
    # @repositories = repository_response.map do |repository|
    #   repository[:name]
    # end
  end
end
