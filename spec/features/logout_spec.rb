require 'rails_helper'

describe 'a user' do
  describe 'visiting the user show page' do
    it 'can log out and return to the root page' do
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

      stub_omni_auth
      visit user_path(user)

      click_link 'Log Out'

      expect(current_path).to eq(root_path)
    end
  end
end
