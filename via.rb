require 'net/https'
require 'uri'
require 'openssl'
module Net
  class HTTPGenericRequest
    def write_header(sock, ver, path)
        buf = "#{@method} #{path} HTTP/#{ver}\r\n"
        each_header do |k,v|
          buf << "#{k}: #{v}\r\n"
        end
        buf << "\r\n"
        sock.write buf
    end
  end
end

# Get Request
uri = URI.parse('https://api.viacom.com/contents/v2/brands/cc/episodes')
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE
request = Net::HTTP::Get.new(uri.request_uri)
request.add_field('x-api-key', 'sP0GwWfyx0MlI3yn4zGNxEZVk0zGh3Ay')
request.add_field('Content-Type', 'application/json')
request.add_field('Cache-Control', 'no-cache')
response = http.request(request)
puts response.body
