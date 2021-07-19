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
      pagination_list_url_job = Nokogiri::HTML(URI.open(pagination_list_url))
      pagination_job_listing = pagination_list_url_job.css('div.job-item')
      pagination_job_listing.each do |detail_jobs|
        pagination_url = detail_jobs.css('a')[1].attributes["href"].value
        parse_pagination_url = Nokogiri::HTML(URI.open(pagination_url))
        pagination_detail_job = parse_pagination_url.css('div.container')
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
        company_url = detail_jobs.css('a')[0].attributes["href"].value
        parse_company_url = Nokogiri::HTML(URI.open(company_url))
        company = parse_company_url.css('div.container')
        puts company.css('div.company-info div.info div.content p.name').text
        company_info = company.css('div.company-info div.info div.content')
        puts company_info.css('p')[1].text 
        puts company_info.css('ul li').text
        puts company.css('div.row div.content p').text.gsub(/\s+/, " ").strip
      end  
      page +=1 
    end 

  end

  desc "TODO"
  task industries: :environment do
    industries_listing = parse_base_url.css('div.container div.list-of-working-positions div.col-md-6.col-lg-4.cus-col')
    puts industries_listing.css('ul.list-jobs li').text
  end

  desc "TODO"
  task cities: :environment do
    cities = parse_base_url.css('div.container div.col-xl-3 div.main-jobs-by-location div.jobs-in-country li a')
    cities.each do |city|
      puts city.text.gsub('Việc làm tại','')
    end
  end

  desc "TODO"
  task regions: :environment do
    puts parse_base_url.css('div.container div.col-xl-3 div.main-jobs-by-location h3').text
  end

  def parse_base_url
    base_url = Nokogiri::HTML(URI.open('https://careerbuilder.vn/'))
    industries_url = base_url.css('div.menu div.dropdown-menu ul li a')[1].attributes["href"].value
    parse_industries_url = Nokogiri::HTML(URI.open(industries_url))
  end
end
