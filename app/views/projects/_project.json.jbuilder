json.extract! project, :id, :name, :team_name, :tag, :eventreferences, :description, :prize, :created_at, :updated_at
json.url project_url(project, format: :json)