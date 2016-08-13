JSONfile = require 'jsonfile'
Twit = require 'twit'
Discord = require 'discord.io'
if not process.env.FFBOTCHANNEL
	console.log 'You need to set FFBOTCHANNEL environment variable! Try:\nexport FFBOTCHANNEL=<channel ID>'
	process.exit 1
else
	channel = process.env.FFBOTCHANNEL

twitter_creds = JSONfile.readFileSync 'twitter_creds.json'
discord_creds = JSONfile.readFileSync 'discord_creds.json'

twitter = new Twit twitter_creds
discord = new Discord.Client discord_creds

twitter_stream = twitter.stream 'user', { track: 'ffsbot' }

twitter_stream.on 'tweet', (tweet) ->
	console.log "Got a tweet! text: #{tweet.text}"
	if tweet.user.screen_name is 'ffsbot'
		console.log "Not retweeting my own post ID #{tweet.id_str}"
	else if tweet.is_quote_status is true
		console.log "Not retweeting quoted status ID #{tweet.id_str}"
	else if tweet.retweeted is true
		console.log "Not retweeting already retweeted status ID #{tweet.id_str}"
	else if tweet.retweeted_status isnt undefined
		console.log "Not retweeting a retweet ID #{tweet.id_str}"
	else if tweet.text.includes('#PS4share') or tweet.text.includes('#PS4live')
		console.log "Retweeting tweet ID #{tweet.id_str}"
		twitter.post 'statuses/retweet/:id', { id: tweet.id_str }, (err, data, res) ->
			console.log "Retweeted ID #{tweet.id_str}, err: #{if err then err else 'None'}"
			if tweet.text.includes '#PS4share'
				console.log "Posting tweet to discord."
				try
					imageUrl = tweet.entities.media[0].media_url_https
					tweetUrl = tweet.entities.media[0].expanded_url
					message = "#{imageUrl}\n#{tweetUrl}"
				catch TypeError
					message = tweet.text
				discord.sendMessage
					to: channel
					message: message
			else if tweet.text.includes '#PS4live'
				console.log "Got a stream announcement. Posting to discord."
				discord.sendMessage
					to: channel
					message: "@#{tweet.user.screen_name} just went live! https://twitter.com/#{tweet.user.screen_name}/status/#{tweet.id_str}"

console.log "Bot is running! Will post to discord channel ID #{channel}"
