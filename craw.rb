require 'nokogiri'
require 'open-uri'
require 'byebug'

def scraper
  base_url = Nokogiri::HTML(URI.open('https://careerbuilder.vn/'))
  #doc va parse url tat ca cac job
  list_url = base_url.css('div.menu div.dropdown-menu ul li a')[0].attributes["href"].value
  list_url_job = Nokogiri::HTML(URI.open(list_url))
  job_listing = list_url_job.css('div.job-item')

  page = 1
  per_page = job_listing.length 
  total = list_url_job.css('div.job-found p').text.split(' ')[0].gsub(',','').to_i
  last_page = (total.to_f / per_page.to_f).round

  while page <= last_page
    pagination_list_url = "https://careerbuilder.vn/viec-lam/tat-ca-viec-lam-trang-#{page}-vi.html"
    pagination_list_url_job = Nokogiri::HTML(URI.open(pagination_list_url))
    pagination_job_listing = pagination_list_url_job.css('div.job-item')
    pagination_job_listing.each do |detail_jobs|
      pagination_url = detail_jobs.css('a')[1].attributes["href"].value
      pagination_detail_url = Nokogiri::HTML(URI.open(pagination_url))
      pagination_detail_job = pagination_detail_url.css('div.container')
      strong_element_value = pagination_detail_job.css('div.detail-box.has-background ul li')
        puts pagination_detail_job.css('div.job-desc h1.title')[0].text
        strong_element_value.each do |title_strong|
          case title_strong.css('strong').text 
            when "Lương"
              puts title_strong.css('p').text.gsub(/\s+/, " ").strip
            when "Kinh nghiệm"
              puts title_strong.css('p').text.gsub(/\s+/, " ").strip
            when "Cấp bậc"
              puts title_strong.css('p').text.gsub(/\s+/, " ").strip
            when "Hết hạn nộp"
              puts title_strong.css('p').text.gsub(/\s+/, " ").strip
            end
        end     
      h3_element_value = pagination_detail_job.css('div.detail-row')
        h3_element_value.each do |h3_element|
          case h3_element.css('h3').text
            when "Mô tả Công việc"
              puts h3_element.css('p').text.gsub(/\s+/, " ").strip
            when "Yêu Cầu Công Việc"
              puts h3_element.css('p').text.gsub(/\s+/, " ").strip
            when "Thông tin khác"
              puts h3_element.css('div.content_fck ul li').text.gsub(/\s+/, " ").strip
            end
        end 
    end

    pagination_job_listing.each do |detail_company|
      company_url = detail_company.css('a')[0].attributes["href"].value
      parse_company_url = Nokogiri::HTML(URI.open(pagination_url))
      company = parse_company_url.css('company-content')
      puts pagination_detail_job.css('div.job-desc a.employer.job-company-name')[0].text
      company.each do |info_company|
        case info_company.css('h3').text
          when "Giới thiệu về công ty"
            puts info_company.css('p').text.gsub(/\s+/, " ").strip
          when "Thông điệp từ CÔNG TY"
            puts info_company.css('p').text.gsub(/\s+/, " ").strip
        end
    end  
    page +=1 
  end  
end


scraper