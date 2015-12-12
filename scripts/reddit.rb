require 'faraday'
require 'faraday_middleware'

conn = Faraday.new(url: 'http://www.reddit.com') do |f|
  f.adapter Faraday.default_adapter
  f.response :json
end

$bot.message(contains: /^\/r\/(.+)$/i) do |event|
  subreddit = event.message.content.sub('/r/','').gsub(' ','')
  json = conn.get("/r/#{subreddit}.json", limit: 100).body
  urls = []

  json['data']['children'].each do |c|
    if c['data']['domain'] != "self.#{subreddit}"
      urls << [c['data']['title'], c['data']['url']]
    end
  end

  event.respond "Couldn't find anything..." if urls.count <= 0

  picked_post = urls.sample
  picked_url = URI::parse(picked_post[1])
  if picked_url.host == 'imgur.com'
    picked_url.host = 'i.imgur.com'
    picked_url.path += '.jpg'
  end

  output = "#{picked_post[0]}: #{picked_url.to_s}"
  event.respond output
end