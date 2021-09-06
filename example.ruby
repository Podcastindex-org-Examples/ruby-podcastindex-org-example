require 'digest'
require 'net/http'

#Required values
apiKey = "ABC123ABC123";
apiSecret = "biglongStringofNumbersAndStuff1234abc";
apiHeaderTime = Time.now.to_i

sha1 = Digest::SHA1.new
sha1 << apiKey
sha1 << apiSecret
sha1 << apiHeaderTime.to_s
hash = sha1.hexdigest

uri = URI('https://api.podcastindex.org/api/1.0/search/byterm?q=bastiat')
req = Net::HTTP::Get.new(uri)
req['User-Agent'] = "ruby-podcastindex-org-example/1.0"
req['X-Auth-Key'] = apiKey
req['X-Auth-Date'] = apiHeaderTime
req['Authorization'] = hash

res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') {|http|
  http.request(req)
}

print(res.body)
