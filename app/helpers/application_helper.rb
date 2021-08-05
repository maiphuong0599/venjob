module ApplicationHelper
  def format_datetime(input)
    input.strftime('%d/%m/%Y')
  end 
end
