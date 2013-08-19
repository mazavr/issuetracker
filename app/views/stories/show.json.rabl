object @story
attributes :id, :title, :text, :state

child user: :user do
  attributes :id, :email
end