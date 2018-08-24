require 'rails_helper'

describe PersonalActivityPresenter, type: :model do
  before :each do
    @personal_activity = PersonalActivityPresenter.new(ENV['JP_TEST_TOKEN'])

    json_response_user = File.open('./spec/fixtures/user.json')
    stub_request(:get, 'https://api.github.com/user').to_return(status:200, body: json_response_user)

    json_response_personal_activities = File.open('./spec/fixtures/personal_activities.json')
    stub_request(:get, 'https://api.github.com/users/JPLynch35/events').to_return(status:200, body: json_response_personal_activities)
  end
  it 'exists' do
    expect(@personal_activity).to be_a(PersonalActivityPresenter)
  end
  describe 'instance methods' do
    it 'returns the user recent commits' do
      expect(@personal_activity.activities).to be_a(Array)
      expect(@personal_activity.activities.first).to be_a(Activity)
      expect(@personal_activity.activities.first.project).to eq('JPLynch35/APIcurious')
      expect(@personal_activity.activities.first.time).to eq('2018-08-23T02:59:11Z')
      expect(@personal_activity.activities.first.commits).to be_a(Array)
      expect(@personal_activity.activities.first.commits.first).to eq('add tests and functionality for following recent activity')
    end
  end
end
