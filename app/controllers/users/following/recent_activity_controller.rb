class Users::Following::RecentActivityController < ApplicationController
  def show
    render file: 'public/404' unless current_user && current_user.id.to_s == params[:user_id]

    @actions = FollowingActivityPresenter.new(current_user.token)
  end
end
