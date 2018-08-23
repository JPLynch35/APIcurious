require 'rails_helper'

describe 'a user' do
  describe 'visiting the splash page' do
    it 'can log in with github oauth' do
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
      visit root_path

      expect(page).to have_content('Welcome to MinimalHub!')
      expect(page).to have_link('Log In with GitHub')

      click_link 'Log In with GitHub'

      expect(page).to have_content('Bobby')
    end
  end
end
