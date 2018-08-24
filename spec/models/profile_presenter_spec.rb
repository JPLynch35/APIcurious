require 'rails_helper'

describe ProfilePresenter, type: :model do
  before :each do
    user = User.create(
      provider: 'github',
      uid: ENV['JP_UID'],
      name: 'JP',
      profile_pic: 'https://avatars0.githubusercontent.com/u/32905782?...',
      token: ENV['JP_TEST_TOKEN']
    )
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    @profile = ProfilePresenter.new(user.token)

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
  end
  it 'exists' do
    expect(@profile).to be_a(ProfilePresenter)
  end
  describe 'instance methods' do
    it 'returns the starred repos of a github user' do
      expect(@profile.num_starred).to eq(1)
    end
    it 'returns the name of followers of a github user' do
      expect(@profile.followers.first).to be_a(GithubUser)
      expect(@profile.followers.count).to eq(4)
    end
    it 'returns the name of those following of a github user' do
      expect(@profile.following.first).to be_a(GithubUser)
      expect(@profile.following.count).to eq(2)
    end
    it 'returns the organization names the github user belongs to' do
      expect(@profile.organizations.first).to be_a(Organization)
      expect(@profile.organizations.count).to eq(1)
    end
    it 'returns the repo titles belonging to a github user' do
      expect(@profile.repositories.first).to be_a(Repository)
      expect(@profile.repositories.count).to eq(42)
    end
  end
end
