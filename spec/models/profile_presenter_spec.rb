require 'rails_helper'

describe ProfilePresenter, type: :model do
  it 'exists' do
    profile = ProfilePresenter.new('hw8723842')

    expect(profile).to be_a(ProfilePresenter)
  end
  describe 'instance methods' do
    it 'returns the starred repos of a github user' do
      user = User.create(
                          provider: 'github',
                          uid: ENV['JP_UID'],
                          name: 'JP',
                          profile_pic: 'https://avatars0.githubusercontent.com/u/32905782?...',
                          token: ENV['JP_TEST_TOKEN']
                        )
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      profile = ProfilePresenter.new(user.token)

      expect(profile.num_starred).to eq(1)
    end
    it 'returns the name of followers of a github user' do
      user = User.create(
                          provider: 'github',
                          uid: ENV['JP_UID'],
                          name: 'JP',
                          profile_pic: 'https://avatars0.githubusercontent.com/u/32905782?...',
                          token: ENV['JP_TEST_TOKEN']
                        )
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      profile = ProfilePresenter.new(user.token)

      expect(profile.followers.first).to be_a(GithubUser)
      expect(profile.followers.count).to eq(3)
    end
    it 'returns the name of those following of a github user' do
      user = User.create(
                          provider: 'github',
                          uid: ENV['JP_UID'],
                          name: 'JP',
                          profile_pic: 'https://avatars0.githubusercontent.com/u/32905782?...',
                          token: ENV['JP_TEST_TOKEN']
                        )
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      profile = ProfilePresenter.new(user.token)

      expect(profile.following.first).to be_a(GithubUser)
      expect(profile.following.count).to eq(2)
    end
    it 'returns the organization names the github user belongs to' do
      user = User.create(
                          provider: 'github',
                          uid: ENV['JP_UID'],
                          name: 'JP',
                          profile_pic: 'https://avatars0.githubusercontent.com/u/32905782?...',
                          token: ENV['JP_TEST_TOKEN']
                        )
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      profile = ProfilePresenter.new(user.token)

      expect(profile.organizations.first).to be_a(Organization)
      expect(profile.organizations.count).to eq(1)
    end
    it 'returns the repo titles belonging to a github user' do
      user = User.create(
                          provider: 'github',
                          uid: ENV['JP_UID'],
                          name: 'JP',
                          profile_pic: 'https://avatars0.githubusercontent.com/u/32905782?...',
                          token: ENV['JP_TEST_TOKEN']
                        )
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      profile = ProfilePresenter.new(user.token)

      expect(profile.repositories.first).to be_a(Repository)
      expect(profile.repositories.count).to eq(42)
    end
  end
end
