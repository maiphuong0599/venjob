require 'open-uri'
namespace :crawler do
  desc "TODO"
  task jobs: :environment do
    base_url = Nokogiri::HTML(URI.open('https://careerbuilder.vn/'))
    list_url = base_url.css('div.menu div.dropdown-menu ul li a')[0].attributes["href"].value
    parse_list_url = Nokogiri::HTML(URI.open(list_url))
    job_listing = parse_list_url.css('div.job-item')
    page = 1
    per_page = job_listing.length 
    total = parse_list_url.css('div.job-found p').text.split(' ')[0].gsub(',','').to_i
    last_page = (total.to_f / per_page.to_f).round
    while page <= last_page
      pagination_list_url = "https://careerbuilder.vn/viec-lam/tat-ca-viec-lam-trang-#{page}-vi.html"
      parse_list_url = Nokogiri::HTML(URI.open(pagination_list_url))
      pagination_job_listing = parse_list_url.css('div.job-item')
      pagination_job_listing.each do |detail_jobs|
        pagination_url = detail_jobs.css('a')[1].attributes["href"].value
        parse_pagination_url = Nokogiri::HTML(URI.open(pagination_url))
        pagination_detail_job = parse_pagination_url.css('div.container')
        strong_element_value = pagination_detail_job.css('div.detail-box.has-background ul li')
        title = pagination_detail_job.css('div.job-desc h1.title')[0].text
          strong_element_value.each do |title_strong|
            case title_strong.css('strong').text 
              when "Lương"
                salary = title_strong.css('p').text.gsub(/\s+/, " ").strip
              when "Kinh nghiệm"
                experience = title_strong.css('p').text.gsub(/\s+/, " ").strip
              when "Cấp bậc"
                level = title_strong.css('p').text.gsub(/\s+/, " ").strip
              when "Hết hạn nộp"
                expired_at = title_strong.css('p').text.gsub(/\s+/, " ").strip
              end
          end      
        h3_element_value = pagination_detail_job.css('div.detail-row')
          h3_element_value.each do |h3_element|
            case h3_element.css('h3').text
              when "Mô tả Công việc"
                overview = h3_element.css('p').text.gsub(/\s+/, " ").strip
              when "Yêu Cầu Công Việc"
                requirement = h3_element.css('p').text.gsub(/\s+/, " ").strip
              when "Thông tin khác"
                other_requirement = h3_element.css('div.content_fck ul li').text.gsub(/\s+/, " ").strip
              end  
          end  
          
        company_url = detail_jobs.css('a')[0].attributes["href"].value
        parse_company_url = Nokogiri::HTML(URI.open(company_url))
        company = parse_company_url.css('div.container')
        comapny = company.css('div.company-info div.info div.content p.name').text
        company_info = company.css('div.company-info div.info div.content')
        address company_info.css('p')[1].text 
        description = company_info.css('ul li').text
        overview = company.css('div.row div.content p').text.gsub(/\s+/, " ").strip
      end  
      page +=1 
    end 

  end

  desc "TODO"
  task industries: :environment do
    industries_listing = parse_base_url.css('div.container div.list-of-working-positions div.col-md-6.col-lg-4.cus-col')
    industries_listing.each do |industries| 
      industries_name = industries.css('ul.list-jobs li').text
      puts 'Added: ' + (industries_name ? industries_name : '')
    end
    
  end

  desc "TODO"
  task cities: :environment do
    cities = parse_base_url.css('div.container div.col-xl-3 div.main-jobs-by-location div.jobs-in-country li a')
    cities.each do |city|
      city_name = city.text.gsub('Việc làm tại','')
      City.find_or_create_by(
        name: city_name        
      )
      Region.find_or_create_by(name: 'Trong nước').id
      puts 'Added: ' + (city_name ? city_name : '')     
    end
    cities_foreign = parse_base_url.css('div.container div.overseas-jobs li a')
    cities_foreign.each do |city|
      city_name = city.text
      City.find_or_create_by(
        name: city_name        
      )
    Region.find_or_create_by(name: 'Nước Ngoài').id
    puts 'Added: ' + (city_name ? city_name : '')
    end
  end


  desc "TODO"
  task regions: :environment do
  regions = parse_base_url.css('div.container div.col-xl-3 div.main-jobs-by-location h3')
    regions.each do |region|
      region_name region.text.gsub('Việc Làm','')
      Region.find_or_create_by(
        name: region_name
      )
    end
  end

  def parse_base_url
    base_url = Nokogiri::HTML(URI.open('https://careerbuilder.vn/'))
    industries_url = base_url.css('div.menu div.dropdown-menu ul li a')[1].attributes["href"].value
    parse_industries_url = Nokogiri::HTML(URI.open(industries_url))
  end
end
