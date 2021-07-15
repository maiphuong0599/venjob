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
      job = {
        title: pagination_detail_job.css('div.job-desc h1.title')[0].text,
        company: pagination_detail_job.css('div.job-desc a')[0].text,
        salary: pagination_detail_job.css('div.detail-box.has-background ul li p')[3].text,
        type: pagination_detail_job.css('div.detail-box.has-background ul li p')[2].text,
        experience: pagination_detail_job.css('div.detail-box.has-background ul li p')[4].text.gsub("\r\n", "").strip,
        level: pagination_detail_job.css('div.detail-box.has-background ul li p')[5].text,
        expired_at: pagination_detail_job.css('div.detail-box.has-background ul li p')[6].text,
        benefits: pagination_detail_job.css('div.detail-row')[0].text.gsub("\r\n", "").strip,
        overview: pagination_detail_job.css('div.detail-row')[1].text.gsub("\r\n", "").strip,
        requirement: pagination_detail_job.css('div.detail-row')[2].text.gsub("\r\n", "").strip,
        other_requirement: pagination_detail_job.css('div.detail-row')[2].text.gsub(/\s+/, " ")
        }
    page +=1
  end
  byebug 
end
scraper