class LogsIndex < Chewy::Index
  define_type Log.includes(:loggable) do
    field :name, value: ->(log) { log.loggable.try(:name) }
    field :severity, :message
    field :at, type: "date", value: -> { created_at }
  end
end
