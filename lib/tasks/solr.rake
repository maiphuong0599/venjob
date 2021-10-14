namespace :solr do
  desc "Add data into apache solr"
  task setup: :environment do
    data = Job.all.includes(:cities, :industries, :company)
    solr = RSolr.connect url: 'http://localhost:8983/solr/VeNJOB'

    data.each do |record|
      id = record.id
      title = record.title
      salary = record.salary
      overview = record.overview
      company = record.company.name
      experience = record.experience
      job_type = record.job_type
      level = record.level
      slug = record.slug

      job_cities = []
      cities = record.cities.uniq
      cities.each do |city|
        city_name = city.name
        job_cities << city_name
      end

      job_industries = []
      industries = record.industries.uniq
      industries.each do |industry|
        industry_name = industry.name
        job_industries << industry_name
      end
      solr.add(id: id, title: title, overview: overview, salary: salary, company: company, experience: experience,
               job_type: job_type, level: level, city: job_cities, industry: job_industries, slug: slug)
      solr.commit
    end
  end
end
