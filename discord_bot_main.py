import discord
import asyncio
import requests
import json
import sys

client = discord.Client()
botToken = sys.argv[1]
channelID = sys.argv[2]

@client.event
async def on_ready():
	if len(sys.argv) > 3:
		print('Logged in as ' + client.user.name + ' (' + client.user.id + ')')
		print('------')
		baseURL = "https://discordapp.com/api/channels/{}/messages".format(channelID)
		headers = { "Authorization":"Bot {}".format(botToken),
	            "User-Agent":"Akylozor (http://akylonia.net, v0.1)",
	            "Content-Type":"application/json", }
		message = '[INFO] '
		for x in sys.argv[3:]:
			message += x + ' '
		POSTedJSON =  json.dumps ( {"content":message} )
		r = requests.post(baseURL, headers = headers, data = POSTedJSON)
	else
		print('Error. Usage: script.py <botToken> <channelID> <msg> [<msg n>]')
	quit()

client.run(botToken)
client.close()
