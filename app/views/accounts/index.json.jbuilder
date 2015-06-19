json.array!(@accounts) do |account|
  json.extract! account, :id, :user_id, :cash, :account_number
  json.url account_url(account, format: :json)
end
