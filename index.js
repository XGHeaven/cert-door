const http2 = require('https')
const fs = require('fs')
const express = require('express')
const path = require('path')

const handler = express()
handler.set('root', __dirname)

handler.get('/', (req, resp) => {
  if (resp.socket.authorized) {
    resp.sendFile(path.join(__dirname, 'authorized.html'))
  } else {
    resp.sendFile(path.join(__dirname, 'unauthorized.html'))
  }
})

handler.get('/client.p12', (_, resp) => {
  resp.sendFile(path.join(__dirname, 'client.p12'))
})

handler.get('/root.crt', (_, resp) => {
  resp.sendFile(path.join(__dirname, 'root.crt'))
})

const app = http2.createServer({
  key: fs.readFileSync('server.key'),
  cert: fs.readFileSync('server.crt'),
  ca: [fs.readFileSync('root.crt')],
  requestCert: true,
  rejectUnauthorized: false
}, handler)

app.listen(3000, () => {
  console.log('listen on 3000')
})
