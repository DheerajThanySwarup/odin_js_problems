require 'rest_client'
url = "http://localhost:3000/users/new"
puts RestClient.get(url)
RestClient.post(url,"")