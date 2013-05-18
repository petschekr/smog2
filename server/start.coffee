express = require "express"
http = require "http"
join = require("path").join

# TODO: add switch parser
if process.argv[2] is "-p" then port = parseInt(process.argv[3]) else port = process.env.PORT or 8080
if port is NaN
  console.error "Listening port was invalid"
  port = process.env.PORT or 8080

# Web server
app = express()
app.use express.static join __dirname, "./public/"
server = http.createServer(app).listen port

console.log "smog2 started on #{port}"