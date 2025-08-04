module ApplicationHelper
  def flash_class(type)
    case type.to_s
    when 'success'
      'positive'
    when 'error'
      'negative'
    when 'alert'
      'warning'
    else
      'info'
    end
  end
end
