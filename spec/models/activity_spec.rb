require 'rails_helper'

describe Activity, type: :model do
  it 'exists' do
    data =  [
              'LittleTruck',
              '2018-08-22T21:24:09Z',
              ['refactored', 'refactored again']
            ]
    activity = Activity.new(data)

    expect(activity).to be_a(Activity)
  end
  it 'has project, time, and commit attributes' do
    data =  [
              'LittleTruck',
              '2018-08-22T21:24:09Z',
              ['refactored', 'refactored again']
            ]
    activity = Activity.new(data)

    expect(activity.project).to eq('LittleTruck')
    expect(activity.time).to eq('2018-08-22T21:24:09Z')
    expect(activity.commits).to eq(['refactored', 'refactored again'])
  end
end
