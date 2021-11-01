module ApplicationHelper
  def format_datetime(input)
    return if input.nil?

    input.strftime('%H:%M : %d/%m/%Y')
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

  def favorite_text(job)
    FavoriteJob.find_by(job: job, user: current_user).present? ? 'Unfavorite' : 'Favorite'
  end

  def cities_for_select
    City.all.map { |city| [city.name, city.id] }
  end

  def industries_for_select
    Industry.all.map { |industry| [industry.name, industry.id]}
  end
end
