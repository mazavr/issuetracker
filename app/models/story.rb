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
      transition [:new, :rejected] => :accepted, :if => :user
    end
    event(:reject) do
      transition [:new, :started] => :rejected
    end
    event(:finish) do
      transition :started => :finished, :if => :user
    end
    event(:start) do
      transition :accepted => :started, :if => :user
    end
  end

  private

  def state_requires_user?
    [:accepted, :started, :finished].include? state_name
  end
end
