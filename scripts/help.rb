$bot.message(contains: /^bot help$/i) do |event|
  commands = [ '/r/subreddit - Returns a random link from the first 100 posts of a subreddit',
  					   '/yt <query> - Returns a selection of the first 10 videos of a Youtube search and returns a dj request command for the selection']
  help = "`#{commands.join("\n\n")}`"
  event.respond help
end