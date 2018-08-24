require 'rails_helper'

describe GithubService do
  before :each do
    user = User.create(
      provider: 'github',
      uid: ENV['JP_UID'],
      name: 'JP',
      profile_pic: 'https://avatars0.githubusercontent.com/u/32905782?...',
      token: ENV['JP_TEST_TOKEN']
    )
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    @service = GithubService.new(user.token)
  end
  it 'exists' do
    expect(@service).to be_a(GithubService)
  end

  describe 'instance methods' do
    it 'gets users starred repos', :vcr do
      starred = @service.call_starred_repos

      expect(starred).to be_a(Array)
      expect(starred.count).to eq(1)
      expect(starred.first).to be_a(Hash)
      expect(starred.first).to have_key(:name)
    end
    it 'gets users followers', :vcr do
      followers = @service.call_followers

      expect(followers).to be_a(Array)
      expect(followers.count).to eq(4)
      expect(followers.first).to be_a(Hash)
      expect(followers.first).to have_key(:login)
    end
    it 'gets users following', :vcr do
      following = @service.call_following

      expect(following).to be_a(Array)
      expect(following.count).to eq(2)
      expect(following.first).to be_a(Hash)
      expect(following.first).to have_key(:login)
    end
    it 'gets users organizations', :vcr do
      organizations = @service.call_organizations

      expect(organizations).to be_a(Array)
      expect(organizations.count).to eq(1)
      expect(organizations.first).to be_a(Hash)
      expect(organizations.first).to have_key(:login)
    end
    it 'gets users repos', :vcr do
      repos = @service.call_repos

      expect(repos).to be_a(Array)
      expect(repos.count).to eq(42)
      expect(repos.first).to be_a(Hash)
      expect(repos.first).to have_key(:name)
    end
    it 'gets users login', :vcr do
      user_info = @service.personal_login

      expect(user_info).to be_a(String)
    end
    it 'gets users personal_activity', :vcr do
      personal_activity = @service.call_personal_activity

      expect(personal_activity).to be_a(Array)
      expect(personal_activity.first).to be_a(Hash)
      expect(personal_activity.first).to have_key(:payload)
      expect(personal_activity.first).to have_key(:actor)
      expect(personal_activity.first).to have_key(:repo)
    end
    it 'refactors users personal_activity', :vcr do
      personal_activity = @service.personal_activity

      expect(personal_activity).to be_a(Array)
      expect(personal_activity.first).to be_a(Array)
    end
    it 'gets users following_activity', :vcr do
      following_activity = @service.call_following_activity

      expect(following_activity).to be_a(Array)
      expect(following_activity.first).to be_a(Array)
      expect(following_activity.first.first).to be_a(Hash)
      expect(following_activity.first.first).to have_key(:payload)
      expect(following_activity.first.first).to have_key(:actor)
      expect(following_activity.first.first).to have_key(:repo)
    end
    it 'refactors users following_activity', :vcr do
      following_activity = @service.following_activity

      expect(following_activity).to be_a(Array)
      expect(following_activity.first).to be_a(Array)
      expect(following_activity.first.first).to be_a(Array)
    end
  end
end
