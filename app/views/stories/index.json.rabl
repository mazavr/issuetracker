object false

child @stories, :object_root => false do
  extends "stories/show"
end

node :paging do
  @paging
end

