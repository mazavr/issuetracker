object @story
attributes :id, :title, :text

child user: :user do
  attributes :id, :email
end