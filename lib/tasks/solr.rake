namespace :solr do
  desc 'Add data into apache solr'
  task setup: :environment do
    connect_solr.add_data
  end

  desc 'Delete data in apache solr'
  task delete_data: :environment do
    connect_solr.delete_data
  end

  def connect_solr
    SolrSearch.new
  end
end
