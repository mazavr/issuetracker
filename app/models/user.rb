class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  has_secure_password
  validates_presence_of :password, :on => :create
  has_many :comments, dependent: :destroy
  has_many :stories, dependent: :destroy
end

