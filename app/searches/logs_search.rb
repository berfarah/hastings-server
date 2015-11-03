class LogsSearch
  include ActiveData::Model

  SORT = { at: { at: :asc }, name: { 'name.sorted' => :asc }, relevance: :_score }

  attribute :query, type: String
  attribute :name, type: String
  attribute :severity, type: String, enum: %w(debug info warning error fatal)
  attribute :from, type: DateTime
  attribute :to, type: DateTime
  attribute :sort, type: String, enum: %w(at name relevance), default: "relevance"

  def index
    LogsIndex
  end

  def search
    [query_string, severity_filter, at_filter, name_filter, sorting].compact.reduce(:merge).load(scope: -> { includes(:loggable) })
  end

  def sorting
    index.order(SORT[sort.to_sym])
  end

  def query_string
    index.query(
      query_string: {
        fields: [:message, :severity, :name],
        query: query,
        default_operator: "and"
      }) if query?
  end

  def name_filter
    index.filter(term: { name: name }) if name?
  end

  def severity_filter
    index.filter(term: { severity: severity }) if severity?
  end

  def at_filter
    body = {}
    body.merge!(gte: from) if from?
    body.merge!(lte: to)   if to?
    index.filter(range: { at: body }) if body.present?
  end
end
