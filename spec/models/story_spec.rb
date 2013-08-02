require 'spec_helper'

describe Story do
  it 'may be created without user' do
     expect { Story.create!(title: 'title', text: 'Test') }.to_not raise_error
  end
  it 'should not be created without user when its required' do
    expect { Story.create!(title: 'title', text: 'Test', state: 'started') }.to raise_error
  end
  it 'should not change state without user when required' do
    story = Story.create!(title: 'title', text: 'Test')
    story.accept!
    story.start.should_not be_true
    expect { story.start! }.to raise_error
    story.state.should eq('accepted')
    story.user = User.new(email: '123')
    story.start.should be_true
    story.state.should eq('started')
  end
end
