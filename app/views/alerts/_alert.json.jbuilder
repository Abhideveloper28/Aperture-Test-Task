json.extract! alert, :id, :alert_type, :description, :tags, :origin, :created_at, :updated_at
json.url alert_url(alert, format: :json)
