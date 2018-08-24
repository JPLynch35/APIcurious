require 'rails_helper'

describe FollowingActivityPresenter, type: :model do
  before :each do
    @following_activity = FollowingActivityPresenter.new(ENV['JP_TEST_TOKEN'])

    json_response_user = File.open('./spec/fixtures/user.json')
    stub_request(:get, 'https://api.github.com/user').to_return(status:200, body: json_response_user)

    json_response_following = File.open('./spec/fixtures/following.json')
    stub_request(:get, 'https://api.github.com/user/following').to_return(status:200, body: json_response_following)

    json_response_following_colinwarmstrong_activities = File.open('./spec/fixtures/following_colinwarmstrong_activities.json')
    stub_request(:get, 'https://api.github.com/users/colinwarmstrong/events').to_return(status:200, body: json_response_following_colinwarmstrong_activities)

    json_response_following_sfreeman422_activities = File.open('./spec/fixtures/following_sfreeman422_activities.json')
    stub_request(:get, 'https://api.github.com/users/sfreeman422/events').to_return(status:200, body: json_response_following_sfreeman422_activities)
  end
  it 'exists' do
    expect(@following_activity).to be_a(FollowingActivityPresenter)
  end
  describe 'instance methods' do
    it 'returns the following users commits' do
      expect(@following_activity.activities).to be_a(Array)
      expect(@following_activity.activities.first).to be_a(Array)
      expect(@following_activity.activities.first.first).to be_a(Activity)
      expect(@following_activity.activities.first.first.project).to eq('sfreeman422/RaspAlarm')
      expect(@following_activity.activities.first.first.time).to eq('2018-08-22T23:49:15Z')
      expect(@following_activity.activities.first.first.commits).to be_a(Array)
      expect(@following_activity.activities.first.first.commits.first).to eq('Adjused hour issue')
    end
  end
end
