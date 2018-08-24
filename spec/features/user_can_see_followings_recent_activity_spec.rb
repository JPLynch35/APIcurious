require 'rails_helper'

describe 'a logged in user ' do
  describe 'visiting the user show page' do
    it 'can click on a link to go the recent activity page for who they follow' do
      user = User.create(
                          provider: 'github',
                          uid: ENV['JP_UID'],
                          name: 'JP',
                          profile_pic: 'https://avatars0.githubusercontent.com/u/32905782?...',
                          token: ENV['JP_TEST_TOKEN']
                        )
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      json_response_starred_repos = File.open('./spec/fixtures/starred_repos.json')
      stub_request(:get, 'https://api.github.com/user/starred').to_return(status:200, body: json_response_starred_repos)

      json_response_followers = File.open('./spec/fixtures/followers.json')
      stub_request(:get, 'https://api.github.com/user/followers').to_return(status:200, body: json_response_followers)

      json_response_following = File.open('./spec/fixtures/following.json')
      stub_request(:get, 'https://api.github.com/user/following').to_return(status:200, body: json_response_following)

      json_response_organizations = File.open('./spec/fixtures/organizations.json')
      stub_request(:get, 'https://api.github.com/user/orgs').to_return(status:200, body: json_response_organizations)

      json_response_repos = File.open('./spec/fixtures/repos.json')
      stub_request(:get, 'https://api.github.com/user/repos?per_page=100&sort=created').to_return(status:200, body: json_response_repos)

      json_response_following_colinwarmstrong_activities = File.open('./spec/fixtures/following_colinwarmstrong_activities.json')
      stub_request(:get, 'https://api.github.com/users/colinwarmstrong/events').to_return(status:200, body: json_response_following_colinwarmstrong_activities)

      json_response_following_sfreeman422_activities = File.open('./spec/fixtures/following_sfreeman422_activities.json')
      stub_request(:get, 'https://api.github.com/users/sfreeman422/events').to_return(status:200, body: json_response_following_sfreeman422_activities)

      visit user_path(user)

      expect(page).to have_link('Following: Recent Activity')

      click_link('Following: Recent Activity')

      expect(current_path).to eq(user_following_recent_activity_path(user))
    end
  end

  describe 'visiting the recent activity page for who they follow' do
    before :each do
      @user = User.create(
        provider: 'github',
        uid: ENV['JP_UID'],
        name: 'JP',
        profile_pic: 'https://avatars0.githubusercontent.com/u/32905782?...',
        token: ENV['JP_TEST_TOKEN']
      )
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end
    it 'can see a summary feed of the recent activity (commits) of who they follow' do
      json_response_following = File.open('./spec/fixtures/following.json')
      stub_request(:get, 'https://api.github.com/user/following').to_return(status:200, body: json_response_following)

      json_response_following_colinwarmstrong_activities = File.open('./spec/fixtures/following_colinwarmstrong_activities.json')
      stub_request(:get, 'https://api.github.com/users/colinwarmstrong/events').to_return(status:200, body: json_response_following_colinwarmstrong_activities)

      json_response_following_sfreeman422_activities = File.open('./spec/fixtures/following_sfreeman422_activities.json')
      stub_request(:get, 'https://api.github.com/users/sfreeman422/events').to_return(status:200, body: json_response_following_sfreeman422_activities)

      visit user_following_recent_activity_path(@user)

      expect(page).to have_content('sfreeman422')
      expect(page).to have_content('MacInnes')
    end
    it 'can click the back button and return to the user show page' do
      json_response_starred_repos = File.open('./spec/fixtures/starred_repos.json')
      stub_request(:get, 'https://api.github.com/user/starred').to_return(status:200, body: json_response_starred_repos)

      json_response_followers = File.open('./spec/fixtures/followers.json')
      stub_request(:get, 'https://api.github.com/user/followers').to_return(status:200, body: json_response_followers)

      json_response_following = File.open('./spec/fixtures/following.json')
      stub_request(:get, 'https://api.github.com/user/following').to_return(status:200, body: json_response_following)

      json_response_organizations = File.open('./spec/fixtures/organizations.json')
      stub_request(:get, 'https://api.github.com/user/orgs').to_return(status:200, body: json_response_organizations)

      json_response_repos = File.open('./spec/fixtures/repos.json')
      stub_request(:get, 'https://api.github.com/user/repos?per_page=100&sort=created').to_return(status:200, body: json_response_repos)

      json_response_following_colinwarmstrong_activities = File.open('./spec/fixtures/following_colinwarmstrong_activities.json')
      stub_request(:get, 'https://api.github.com/users/colinwarmstrong/events').to_return(status:200, body: json_response_following_colinwarmstrong_activities)

      json_response_following_sfreeman422_activities = File.open('./spec/fixtures/following_sfreeman422_activities.json')
      stub_request(:get, 'https://api.github.com/users/sfreeman422/events').to_return(status:200, body: json_response_following_sfreeman422_activities)

      visit user_following_recent_activity_path(@user)
      click_link 'Back'

      expect(current_path).to eq(user_path(@user))
    end
  end
end
