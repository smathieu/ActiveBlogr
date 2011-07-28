require 'uri'
require 'net/http'

URL = 'http://andreeetsimon.blogspot.com'

#uri = URI(URL)
#http = Net::HTTP.new(uri.host, uri.port)
#
#headers = {
#  'Accept' => 'application/rss+xml'
#}
#
#path = uri.path.empty? ? "/" : uri.path
#
#response = http.get(path, headers)
#puts response
#

url = URI.parse(URL)

path = url.path.empty? ? "/" : url.path

req = Net::HTTP::Get.new(path)
req.add_field("Accept", "application/rss+xml")

res = Net::HTTP.new(url.host, url.port).start do |http|
  http.request(req)
end

puts res.body
#
