require 'rails_helper'

describe ProjectPush, type: :model do
  it 'exists' do
    data =  {
              name: 'Dave'
            }
    activity = ProjectPush.new(data)

    expect(activity).to be_a(Githubactivity)
  end
  it 'has project, time, and commit attributes' do
    data = {login: 'Dave'}
    activity = ProjectPush.new(data)

    expect(activity.project).to eq('Dave')
    expect(activity.time).to eq('Dave')
    expect(activity.commits.count).to eq('Dave')
  end
end
