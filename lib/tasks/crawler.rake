require 'open-uri'

namespace :crawler do
  desc 'Crawl Jobs and Companies'
  task jobs: :environment do
    base_url = Nokogiri::HTML(URI.open('https://careerbuilder.vn/'))
    job_page = base_url.css('div.menu div.dropdown-menu ul li a')[0].attributes['href'].value
    parse_job_page = Nokogiri::HTML(URI.open(job_page))
    job_listing = parse_job_page.css('div.job-item')
    per_page = job_listing.present? ? job_listing.length : 0
    page = 1
    total = parse_job_page.css('div.job-found p').text.split(' ')[0].gsub(',', '').to_i
    last_page = (total.to_f / per_page).round

    while page <= last_page
      pagination_page_job = "https://careerbuilder.vn/viec-lam/tat-ca-viec-lam-trang-#{page}-vi.html"
      parse_pagination_page_job = Nokogiri::HTML(URI.open(pagination_page_job))
      pagination_job_listing = parse_pagination_page_job.css('div.job-item')
      pagination_job_listing.each do |detail_jobs|
        company_url = detail_jobs.css('a.company-name').attribute('href').text
        next if company_url == 'javascript:void(0);'
        slug_company = CGI.escape(company_url.gsub('https://careerbuilder.vn/vi/nha-tuyen-dung/', '').strip)
        company_page = "https://careerbuilder.vn/vi/nha-tuyen-dung/#{slug_company}"
        puts company_page
        parse_company_page = Nokogiri::HTML(URI.open(company_page))
        company = parse_company_page.css('div.container')
        company_name = company.css('div.company-info div.content p.name')
        next if company_name.nil?
        name = company.css('div.company-info div.content p.name').text
        company_info = company.css('div.company-info div.content')
        address = company_info.css('p')[1].try(:text)
        description = company_info.css('ul li').text
        overview = company.css('div.row div.content p').text.squish.strip
        Company.find_or_create_by(
          name: name,
          address: address,
          description: description,
          overview: overview
        )

        slug_job = CGI.escape(detail_jobs.css('a.job_link').attribute('href').text
        .gsub('https://careerbuilder.vn/vi/tim-viec-lam/', '').strip)
        job_detail_page = "https://careerbuilder.vn/vi/tim-viec-lam/#{slug_job}"
        puts job_detail_page
        parse_job_detail_page = Nokogiri::HTML(URI.open(job_detail_page))
        detail_job = parse_job_detail_page.css('div.container')
        title = detail_job.css('div.job-desc h1.title')
        next if title.nil?
        title_job = detail_job.css('div.job-desc h1.title').text
        salary, experience, type, level, expired_at = ''
        detail_content = detail_job.css('div.detail-box.has-background ul li')
        detail_content.each do |content|
          case content.css('strong').text
          when 'Lương'
            salary = content.css('p').text
          when 'Kinh nghiệm'
            experience = content.css('p').text
          when 'Hình thức'
            type = content.css('p').text
          when 'Cấp bậc'
            level = content.css('p').text
          when 'Hết hạn nộp'
            expired_at = content.css('p').text
          end
        end
        benefits, overview, requirement, other_requirement = ''
        detail_require = detail_job.css('div.detail-row')
        detail_require.each do |detail|
          case detail.css('h3').text
          when 'Phúc lợi '
            benefits = detail.css('ul li').text
          when 'Mô tả Công việc'
            overview = detail.css('p').text
          when 'Yêu Cầu Công Việc'
            requirement = detail.css('p').text
          when 'Thông tin khác'
            other_requirement = detail.css('div.content_fck ul li').text.squish
          end
        end

        job = Job.find_or_create_by(
          title: title_job,
          salary: salary,
          experience: experience,
          type: type,
          level: level,
          expired_at: expired_at,
          benefits: benefits,
          overview: overview,
          requirement: requirement,
          other_requirement: other_requirement,
          company_id: Company.find_by(name: name).id
        )

        industries = detail_job.css('div.detail-box.has-background ul li p a')
        industries.each do |industry|
        industry_name = industry.text.squish
        industries = Industry.find_or_create_by(
          name: industry_name
        )
        job.industries << industries
        end

        location = detail_job.css('div.map p a')
        location.each do |city|
          city_name = city.text
          cities = City.find_or_create_by(
            name: city_name
          )
          job.cities << cities
        end
      end
      page += 1
    end
  end

  desc 'Crawl Industries'
  task industries: :environment do
    industries_listing = parse_base_url.css('div.col-md-6.col-lg-4.cus-col ul.list-jobs li a')
    industries_listing.each do |industry|
      industry_name = industry.text
      Industry.find_or_create_by(
        name: industry_name
      )
    end
  end

  desc 'Crawl Cities'
  task cities: :environment do
    cities = parse_base_url.css('div.container div.jobs-in-country li a')
    cities.each do |city|
      city_name = city.text.gsub('Việc làm tại', '').strip
      City.find_or_create_by(
        name: city_name,
        region_id: Region.find_by(name: 'Trong Nước').id
      )
    end
    cities_foreign = parse_base_url.css('div.container div.overseas-jobs li a')
    cities_foreign.each do |city|
      city_name = city.text.strip
      City.find_or_create_by(
        name: city_name,
        region_id: Region.find_by(name: 'Nước Ngoài').id
      )
    end
  end

  desc 'Crawl Regions'
  task regions: :environment do
    regions = parse_base_url.css('div.container div.col-xl-3 div.main-jobs-by-location h3')
    regions.each do |region|
      region_name = region.text.gsub('Việc Làm', '').strip
      Region.find_or_create_by(
        name: region_name
      )
    end
  end

  def parse_base_url
    base_url = Nokogiri::HTML(URI.open('https://careerbuilder.vn/'))
    industries_url = base_url.css('div.menu div.dropdown-menu ul li a')[1].attributes['href'].value
    Nokogiri::HTML(URI.open(industries_url))
  end
end
