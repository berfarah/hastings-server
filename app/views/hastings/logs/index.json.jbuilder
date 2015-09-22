json.array!(@logs) do |log|
  json.extract! log, :id, :severity, :message, :task_id
  json.url log_url(log, format: :json)
end
