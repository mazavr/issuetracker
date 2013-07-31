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
          '<li></li>'
        end)
      end
    else
      story.state
    end


    #content_tag(:div, :class => "list") do
    #  collection.collect do |member|
    #    content_tag(:li, :id => member.name.gsub(' ', '-').downcase.strip) do
    #      member.name
    #    end
    #  end
    #end

    #button
  end
end
