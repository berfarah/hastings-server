# Set ELASTICSEARCH_ADDRESS_INT if not using localhost:9200
Elasticsearch::Model.client = Elasticsearch::Client.new(
  host: ENV["ELASTICSEARCH_ADDRESS_INT"] || "localhost:9200"
)
