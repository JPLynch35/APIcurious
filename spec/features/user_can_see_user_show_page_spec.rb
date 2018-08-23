require 'rails_helper'

describe 'a logged in user ' do
  describe 'visiting the user show page' do
    it 'can see their profile pic, name, number of starred repos, number of followers, number followings, list of organizations, and list of all repos' do
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

      visit user_path(user)

      expect(page).to have_content("Number of Starred Repo: 1")
      expect(page).to have_content("Followers:")
      expect(page).to have_css(".follower", count: 4)
      expect(page).to have_content("Following:")
      expect(page).to have_css(".following", count: 2)
      expect(page).to have_content("Organizations:")
      expect(page).to have_css(".organization", count: 1)
      expect(page).to have_content("Repositories:")
      expect(page).to have_css(".repository", count: 42)
    end
  end
end
