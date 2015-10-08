# Set ELASTICSEARCH_ADDRESS_INT if not using localhost:9200
client = Elasticsearch::Client.new host:
  ENV["ELASTICSEARCH_ADDRESS_INT"] || "http://localhost:9200"

Log.__elasticsearch__.client = client
