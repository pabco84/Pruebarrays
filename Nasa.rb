require "uri"
require "net/http"
require "JSON"

def request(address, key)
    url = URI("#{address}&api_key=#{key}")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = https.request(request)
    JSON.parse response.read_body
end

body = request('https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10&', 'nvnFdcayJYf9cj5RRagvx5WXUmj4FcY3YwdN4Jk0')

dire = []
body['photos'].each do |x|
    dire.push x['img_src']
end

def build_web_page(dire)
    File.open("index.html", "w") do |f|
        f.write("<html>\n")
        f.write("<head>\n<title>NASA</title>\n</head>\n")
        f.write("<body>\n")
        f.write("<ul>\n")
        dire.count.times do |i|
        f.write("\t<li><img src='#{dire[i]}'></li>\n")
        end
        f.write("</ul>\n")
        f.write("</body>\n</html>\n")
    end
end

build_web_page(dire)
