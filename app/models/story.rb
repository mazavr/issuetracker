class Story < ActiveRecord::Base
  attr_accessible :title, :text, :user_id, :attachments_attributes, :state

  belongs_to :user

  acts_as_commentable

  has_many :attachments, :as => :attachable

  accepts_nested_attributes_for :attachments, :allow_destroy => true

  validates_presence_of :user, :if => :state_requires_user?
  validates_presence_of :title

  state_machine :initial => :new do
    event(:accept) do
      transition [:new, :rejected] => :accepted
    end
    event(:reject) do
      transition [:new, :started] => :rejected
    end
    event(:finish) do
      transition :started => :finished
    end
    event(:start) do
      transition :accepted => :started
    end
    state :started, :finished do
      validates_presence_of :user
    end
  end

  def self.state_requires_user(state)
    [:started, :finished].include? state.to_sym
  end

  def state_requires_user?
    self.class.state_requires_user state_name
  end
end
