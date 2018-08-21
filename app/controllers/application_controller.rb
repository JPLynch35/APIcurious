class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :conn

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def conn
    Faraday.new(url: 'https://api.github.com/user') do |faraday|
      faraday.headers['Authorization'] = "token #{current_user.token}"
      faraday.adapter Faraday.default_adapter
    end
  end
end
