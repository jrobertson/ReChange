require 'json'
require 'net/http'


def get_response(uri)

  subscription_key, bearer = load_auth()
  puts [subscription_key, bearer].inspect
  uri.query = URI.encode_www_form({
  })

  request = Net::HTTP::Get.new(uri.request_uri)
  # Request headers
  request['Ocp-Apim-Subscription-Key'] = subscription_key
  request['bearer'] = bearer

  response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      http.request(request)
  end

end

def post_response(uri, payload)

  subscription_key, bearer = load_auth()

  uri.query = URI.encode_www_form({
  })

  request = Net::HTTP::Post.new(uri.request_uri)
  # Request headers
  request['Ocp-Apim-Subscription-Key'] = subscription_key
  request['bearer'] = bearer
  request.body payload

  response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      http.request(request)
  end

end

def load_auth()

  s = File.read('auth.txt')
  s.match(/subscription_key: (\w+)\nbearer: ([\w\.]+)/m).captures

end

def rounding(raw_money)

  money = raw_money.to_f
  # under 5 pounds

  newval = if money < 5 then

    # round to the nearest 10 pence
    money.round(1)

  # over 5 under 15 pounds

  elsif money > 5 and money < 15

    v = money.to_i
    #  round to nearest 50 pence
    money % v < 0.50 ? v + 0.50 : v+=1

  # over 15 pounds round to nearest pound

  else

    v = money.to_i
    v == money ? money : v+= 1
  end

end

def totalise_difference(a)
  total = 0
  a2 = a.each {|x| total += x.last}
  total
end
