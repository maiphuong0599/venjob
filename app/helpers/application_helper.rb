module ApplicationHelper
  def format_datetime(input)
    return if input.nil?

    input.strftime('%d/%m/%Y')
  end
end
