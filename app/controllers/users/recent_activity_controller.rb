class Users::RecentActivityController < ApplicationController
  def show
    render file: 'public/404' unless current_user && current_user.id.to_s == params[:user_id]

    user_reponse = conn.get('user')
    user = JSON.parse(user_reponse.body, symbolize_names: true)[:login]

    events_reponse = conn.get("users/#{user}/events")
    events = JSON.parse(events_reponse.body, symbolize_names: true)
    @recent_activity = events.map do |event|
      if event[:payload][:commits] && event[:actor][:login] == user
        [event[:repo][:name], event[:created_at],
        event[:payload][:commits].map do |commit|
          commit[:message]
        end
        ]
      end
    end.compact
  end
end
