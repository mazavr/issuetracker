module StoriesHelper
  #.btn-group
  #  a.btn.dropdown-toggle.btn-info data-toggle="dropdown" href="#"
  #  ' New
  #   span.caret
  #  ul.dropdown-menu
  #    li = link_to 'Accept', story_path(story, 'story[state]' => 'accepted'), method: :put
  #    li = link_to 'Take', ''
  #    li.divider
  #    li = link_to 'Reject', ''
  def story_state_actions(story)
    if story.state == 'new'
      content_tag :div, class: 'btn-group' do
        concat content_tag(:div, class: 'btn dropdown-toggle btn-info', 'data-toggle' => 'dropdown', href: '#') {
          concat 'New '
          concat content_tag(:span, '', class: 'caret')
        }
        concat(content_tag(:ul, class: 'dropdown-menu') do
          concat content_tag(:li) {
            concat link_to 'Accept', story_path(story, 'story[state]' => 'accepted'), method: :put
          }
          if story.user
            concat content_tag(:li) {
              concat link_to 'Start', story_path(story, 'story[state]' => 'started'), method: :put
            }
          else
            concat content_tag(:li) {
              concat link_to 'Take', story_path(story, 'story[user_id]' => current_user), method: :put
            }
            concat content_tag(:li) {
              concat link_to 'Take & start', story_path(story, 'story[state]' => 'started', 'story[user_id]' => current_user), method: :put
            }
          end
          concat content_tag(:li, '', class: 'divider')
          concat content_tag(:li) {
            concat link_to 'Reject', story_path(story, 'story[state]' => 'rejected'), method: :put
          }
        end)
      end
    else
      story.state
    end

  end
end
