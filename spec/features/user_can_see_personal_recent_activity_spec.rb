require 'rails_helper'

describe 'a logged in user ' do
  describe 'visiting the user show page' do
    it 'can click on a link to go to their personal recent activity page' do
      user = User.create(
                          provider: 'github',
                          uid: ENV['JP_UID'],
                          name: 'JP',
                          profile_pic: 'https://avatars0.githubusercontent.com/u/32905782?...',
                          token: ENV['JP_TEST_TOKEN']
                        )
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      json_response_user = File.open('./spec/fixtures/user.json')
      stub_request(:get, 'https://api.github.com/user').to_return(status:200, body: json_response_user)

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

      json_response_personal_activities = File.open('./spec/fixtures/personal_activities.json')
      stub_request(:get, 'https://api.github.com/users/JPLynch35/events').to_return(status:200, body: json_response_personal_activities)

      visit user_path(user)

      expect(page).to have_link('Personal: Recent Activity')

      click_link('Personal: Recent Activity')

      expect(current_path).to eq(user_recent_activity_path(user))
    end
  end

  describe 'visiting the user recent activity page' do
    it 'can see a summary feed of their recent activity (commits)' do
      user = User.create(
                          provider: 'github',
                          uid: ENV['JP_UID'],
                          name: 'JP',
                          profile_pic: 'https://avatars0.githubusercontent.com/u/32905782?...',
                          token: ENV['JP_TEST_TOKEN']
                        )
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      json_response_user = File.open('./spec/fixtures/user.json')
      stub_request(:get, 'https://api.github.com/user').to_return(status:200, body: json_response_user)

      json_response_personal_activities = File.open('./spec/fixtures/personal_activities.json')
      stub_request(:get, 'https://api.github.com/users/JPLynch35/events').to_return(status:200, body: json_response_personal_activities)

      visit user_recent_activity_path(user)

      expect(page).to have_content('Repo: JPLynch35/APIcurious')
      expect(page).to have_content('Time: 2018-08-22T01:17:36Z')
      expect(page).to have_content('add feature test for repository list')
    end
    it 'can click the back button and return to the user show page' do
      user = User.create(
                          provider: 'github',
                          uid: ENV['JP_UID'],
                          name: 'JP',
                          profile_pic: 'https://avatars0.githubusercontent.com/u/32905782?...',
                          token: ENV['JP_TEST_TOKEN']
                        )
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      json_response_user = File.open('./spec/fixtures/user.json')
      stub_request(:get, 'https://api.github.com/user').to_return(status:200, body: json_response_user)

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

      json_response_personal_activities = File.open('./spec/fixtures/personal_activities.json')
      stub_request(:get, 'https://api.github.com/users/JPLynch35/events').to_return(status:200, body: json_response_personal_activities)

      visit user_recent_activity_path(user)
      click_link 'Back'

      expect(current_path).to eq(user_path(user))
    end
  end
end
