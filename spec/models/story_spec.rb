require 'spec_helper'

describe Story do
  it 'may be created without user' do
     expect { Story.create!(text: 'Test') }.to_not raise_error
  end
  it 'should not be created without user when its required' do
    expect { Story.create!(text: 'Test', state: 'started') }.to raise_error
  end
  it 'should not change state without user when required' do
    story = Story.create!(text: 'Test')
    story.accept.should_not be_true
    expect { story.accept! }.to raise_error
    story.state.should eq('new')
    story.user = User.new(email: '123')
    story.accept.should be_true
    story.state.should eq('accepted')
  end
end
