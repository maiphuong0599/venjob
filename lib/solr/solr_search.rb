class SolrSearch
  def initialize
    @solr = RSolr.connect url: 'http://localhost:8983/solr/VeNJOB'
  end

  def search(keyword, current_page)
    @solr.paginate current_page, 20, 'select', params: {
      q: "cities_name: #{keyword} or title: #{keyword} or industries_name: #{keyword} or company_name: #{keyword}",
      fl: 'job_id'
    }
  end

  def add_data
    logger = Logger.new("#{Rails.root}/log/add_data_solr.log")
    logger.info "Start add data at: #{Time.current}"
    data = Job.all.includes(:cities, :industries, :company)
    data.each do |record|
      job_id = record.id
      title = record.title
      company_name = record.company.name
      cities = record.cities.uniq.map(&:name)
      industries = record.industries.uniq.map(&:name)
      slug = record.slug
      @solr.add(job_id: job_id, title: title, company_name: company_name, cities_name: cities,
                industries_name: industries, slug: slug)
      @solr.commit

    rescue StandardError => error
      logger.error("The job has error: #{job_id}")
      logger.error(error)
      next
    end
    logger.info "End add data at: #{Time.current}"
  end

  def delete_data
    @solr.delete_by_query '*:*'
    @solr.commit
  end
end
