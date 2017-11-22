#!/usr/bin/python3

import socket

s = socket.socket()
port = 443
s.bind(('',port))
s.listen(5)
print("Listening")
while True:
  c, addr = s.accept()
  print("Connection!")
  data = c.recv(16)
  if data:
    print(data)
  else:
    print("No input")
    break
  c.close()
s.close()
