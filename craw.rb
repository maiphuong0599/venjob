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
  per_page = job_listing.count 
  total = list_url_job.css('div.job-found p').text.split(' ')[0].gsub(',','').to_i
  last_page = (total.to_f / per_page.to_f).round

  while page <= last_page
    pagination_list_url = "https://careerbuilder.vn/viec-lam/tat-ca-viec-lam-trang-#{page}-vi.html"
    pagination_list_url_job = Nokogiri::HTML(URI.open(pagination_list_url))
    pagination_job_listing = pagination_list_url_job.css('div.job-item')
    pagination_url = pagination_job_listing.css('a')[1].attributes["href"].value
    pagination_detail_url = Nokogiri::HTML(URI.open(pagination_url))
    pagination_detail_job = pagination_detail_url.css('div.container')
    
        title = pagination_detail_job.css('div.job-desc h1.title')[0].text,
        company = pagination_detail_job.css('div.job-desc a.employer.job-company-name')[0].text,
        class_value = pagination_detail_job.css('div.detail-box.has-background ul li').children
        
        class_value.each do |title|
          if title.attributes["class"].value == "fa fa-usd"
            salary = pagination_detail_job.css('div.detail-box.has-background ul li p').text.gsub(/\s+/, " ")
          elsif title.attributes["class"].value == "fa fa-briefcase"
            experience = pagination_detail_job.css('div.detail-box.has-background ul li p').text.gsub("\r\n", "").strip
          elsif title.attributes["class"].value == "mdi mdi-account"
            type = pagination_detail_job.css('div.detail-box.has-background ul li p').text.gsub(/\s+/, " ")
          elsif title.attributes["class"].value == "mdi mdi-calendar-check"
            expired_at = pagination_detail_job.css('div.detail-box.has-background ul li p').text.gsub(/\s+/, " ")
          end
        end
       
        benefits = pagination_detail_job.css('div.detail-row')[0].text.gsub("\r\n", "").strip,
        overview = pagination_detail_job.css('div.detail-row')[1].text.gsub("\r\n", "").strip,
        requirement = pagination_detail_job.css('div.detail-row')[2].text.gsub("\r\n", "").strip,
        other_requirement = pagination_detail_job.css('div.detail-row')[2].text.gsub(/\s+/, " ")
    page +=1
    
  end
  byebug
end
scraper