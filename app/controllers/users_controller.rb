class UsersController < ApplicationController
  def show
    render file: 'public/404' unless current_user && current_user.id.to_s == params[:id]
    @profile = ProfilePresenter.new(current_user.token)
  end
end
