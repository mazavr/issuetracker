module GridHelper
  def row_class_for_state(state)
    case state
      when 'new'
        'info'
      when 'finished'
        'success'
      when 'rejected'
        'error'
      else
        'warning'
    end
  end
end