http = require "http"
fs = require "fs"
{join} = require "path"

{MongoClient} = require "mongodb"
express = require "express"
WSServer = require("ws").Server

commander.version "2.0.0"
commander.usage "[options]"
commander.option "-p, --port <n>", "The port for smog to listen on (HTTP) (8080)", parseInt
commander.option "-w, --ws-port <n>", "The port for the WebSocket server to listen on (8079)", parseInt
commander.parse process.argv

port = commander.port
if isNaN port
	console.error "HTTP listening port was invalid"
	port = process.env.PORT or 8080
if port is undefined
	port = process.env.PORT or 8080
WSPort = commander.ws-port
if isNaN WSPort
	console.error "WebSocket listening port was invalid"
	WSPort = 8079
if WSPort is undefined
	WSPort = 8079

# HTTP server
app = express()
app.use express.static join __dirname, "./public/"

server = http.createServer(app).listen port
# WebSocket server
WSPort = 8079
wss = new WSServer port: WSPort
wss.on "connection", (ws) ->
	ws.on "open", ->
		# The WS connection has opened
		
	ws.on "message", (message) ->
		try
			message = JSON.parse message
		catch e
			# Terminate the connection if invalid JSON is passed
			ws.terminate()
			return
	ws.on "close", ->
		# WS connection was closed

console.log "smog2 started on #{port}"