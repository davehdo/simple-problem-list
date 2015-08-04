json.array!(@plans) do |plan|
  json.extract! plan, :id, :history, :content
  json.url plan_url(plan, format: :json)
end
