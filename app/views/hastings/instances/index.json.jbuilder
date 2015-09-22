json.array!(@instances) do |instance|
  json.extract! instance, :id, :finished_at, :failed, :task_id
  json.url instance_url(instance, format: :json)
end
