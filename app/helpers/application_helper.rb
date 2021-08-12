module ApplicationHelper
  def format_datetime(input)
    return if input.nil?

    input.strftime('%d/%m/%Y')
  end

  def class_active(link_path)
    return unless current_page?(link_path)

    'active'
  end

  def current_page?(*paths)
    paths.include?(request.path)
  end
end
