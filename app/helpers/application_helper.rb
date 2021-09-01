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

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  rescue
    render_404
  end

  def render_404
    render file: "#{Rails.root}/public/404.html", status: :not_found
  end

  def favorite_text
    return @favorite_exists ? 'Unfavorite' : 'Favorite'
  end
end
