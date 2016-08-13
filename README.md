First Frontier Sharing Bot
==========================

This is a bot made for the First Frontier No Man's Sky community to bridge the media sharing gap between PS4 and PC players. PC players can easily share screenshots but PS4 players don't have it so easy. This can be used to share any sort of PS4 media to a Discord channel of your choosing.

You will need a file discord\_creds.json with the following information:

```json
{
	"token": "YOUR DISCORD BOT TOKEN"
	"autorun": true
}
```

Note that this is a [discord.io](https://github.com/izy521/discord.io) config object, thus the `autorun: true`

You will also need a file twitter\_creds.json with the following information:

```json
{
	"consumer_key"        : "YOUR CONSUMER KEY"
	"consumer_secret"     : "YOUR CONSUMER SECRET"
	"access_token"        : "YOUR ACCESS TOKEN"
	"access_token_secret" : "YOUR ACCESS TOKEN SECRET"
}
```

Finally, set an environment variable named `FFBOTCHANNEL` containing the Discord channel ID that the bridge will post to.

```bash
export FFBOTCHANNEL=1111111111
```

or...

```bash
FFBOTCHANNEL=1111111111 coffee app.coffee
```

Note
====

Since this is written in coffeescript you'll want to install coffeescript globally

```bash
sudo npm install -g coffee-script
```

