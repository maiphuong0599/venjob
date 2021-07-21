require 'open-uri'

namespace :crawler do
  desc 'Crawl Jobs and Companies'
  task jobs: :environment do
    base_url = Nokogiri::HTML(URI.open('https://careerbuilder.vn/'))
    job_page = base_url.css('div.menu div.dropdown-menu ul li a')[0].attributes['href'].value
    parse_job_page = Nokogiri::HTML(URI.open(job_page))
    job_listing = parse_job_page.css('div.job-item')
    page = 1
    per_page = job_listing.length
    total = parse_job_page.css('div.job-found p').text.split(' ')[0].gsub(',', '').to_i
    last_page = (total.to_f / per_page).round

    while page <= last_page
      pagination_page_job = "https://careerbuilder.vn/viec-lam/tat-ca-viec-lam-trang-#{page}-vi.html"
      parse_pagination_page_job = Nokogiri::HTML(URI.open(pagination_page_job ))
      pagination_job_listing = parse_pagination_page_job.css('div.job-item')
      pagination_job_listing.each do |detail_jobs|
        company_page = detail_jobs.css('a.company-name').attribute('href').value
        parse_company_url = Nokogiri::HTML(URI.open(company_page))
        company = parse_company_url.css('div.container')
        company_name = company.css('div.company-info div.content p.name').text
        company_info = company.css('div.company-info div.content')
        address = company_info.css('p')[1].text
        description = company_info.css('ul li').text
        overview = company.css('div.row div.content p').text.gsub(/\s+/, '').strip
        Company.find_or_create_by(
          name: company_name,
          address: address,
          description: description,
          overview: overview
        )

        job_detail_page = detail_jobs.css('a.job_link').attribute('href').value
        parse_job_detail_page = Nokogiri::HTML(URI.open(job_detail_page))
        detail_job = parse_job_detail_page.css('div.container')

        title = detail_job.css('div.job-desc h1.title').text

        salary, experience, level, expired_at = ''
        industry_type = []
        detail_content = detail_job.css('div.detail-box.has-background ul li')
        detail_content.each do |content|
          case content.css('strong').text
          when 'Lương'
            salary = content.css('p').text.gsub(/\s+/, '').strip
          when 'Kinh nghiệm'
            experience = content.css('p').text.gsub(/\s+/, '').strip
          when 'Cấp bậc'
            level = content.css('p').text.gsub(/\s+/, '').strip
          when 'Ngành nghề'
            industry_type = content.css('p a')
          when 'Hết hạn nộp'
            expired_at = content.css('p').text.gsub(/\s+/, '').strip
          end
        end

        benefits, overview, requirement, other_requirement = ''
        detail_require = detail_job.css('div.detail-row')
        detail_require.each do |detail|
          case detail.css('h3').text
          when 'Phúc lợi '
            benefits = detail.css('ul li').text.strip
          when 'Mô tả Công việc'
            overview = detail.css('p').text.strip
          when 'Yêu Cầu Công Việc'
            requirement = detail.css('p').text.strip
          when 'Thông tin khác'
            other_requirement = detail.css('div.content_fck ul li').text.gsub('\r\n', '').strip
          end
        end
        job = Job.find_or_create_by(
          title: title,
          salary: salary,
          experience: experience,
          level: level,
          expired_at: expired_at,
          benefits: benefits,
          overview: overview,
          requirement: requirement,
          other_requirement: other_requirement,
          company_id: Company.find_by(name: company_name).id
        )

        industry_type.each do |industry|
          industry_name = industry.text.gsub(/\s+/, '').split('/')
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
    industries_listing = parse_base_url.css('div.container div.list-of-working-positions div.col-md-6.col-lg-4.cus-col')
    industries_listing.each do |industries|
      industries_type = industries.css('ul.list-jobs li')
      industries_type.each do |industries_name|
        name = industries_name.text
        Industry.find_or_create_by(
          name: name
        )
      end
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
