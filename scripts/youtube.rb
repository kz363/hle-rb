require 'open-uri'
require 'nokogiri'

$bot.message(start_with: '/yt ') do |yt_event|
  $bot.remove_event_handler(Discordrb::Events::MessageEvent, contains: /^\d{1,2}$/i)
  query = yt_event.content.gsub('/yt ', '')
  page = Nokogiri::HTML(open(URI.escape("https://www.youtube.com/results?search_query=#{query}")), nil, 'utf-8')
  videos = page.css('.yt-lockup-title a')
               .reject { |v| href = v['href']
                             href.include?('list=') ||
                             href.include?('channel/') ||
                             href.include?('user/')
                        }
               .first(10)

  if videos.empty?
    yt_event.respond 'No videos found'
  else
    videos_list = "```Enter a number:\n"
    video_times = page.css('.video-time')
                      .first(10)
                      .reject(&:nil?)
                      .map(&:text)

    videos.map{ |v| v['title'] }.each_with_index do |v, i|
      videos_list << "#{i+1} - #{v} (#{video_times[i]})"
      i == videos.length - 1 ? videos_list << '```' : videos_list << "\n"
    end

    yt_event.respond videos_list

    $bot.message(contains: /^\d{1,2}$/i) do |resp_event|
      index = resp_event.content.to_i - 1
      video = videos[index]['href']
      command = "dj request https://www.youtube.com#{video}"
      resp_event.respond command
      $bot.remove_event_handler(Discordrb::Events::MessageEvent, contains: /^\d{1,2}$/i)
    end
  end
end