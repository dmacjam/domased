json.array!(@facebook_places) do |facebook_place|
  json.extract! facebook_place, :id, :place_id, :checked
  json.url facebook_place_url(facebook_place, format: :json)
end
