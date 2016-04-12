# graphite-relay

Because the clock of the esp8266 is more or less unusable, we'll relay our
graphite-values over a reaspberry-pi which is running node-red and simply
adds the timestamp to the value like this:


something like this:

[{"id":"82ef0a16.17d9f8","type":"tcp in","z":"c14940d6.cf7c08","name":"graphite relay","server":"server","host":"","port":"2003","datamode":"single","datatype":"utf8","newline":"","topic":"","base64":false,"x":112,"y":340.5,"wires":[["1acd2c04.980484"]]},{"id":"1acd2c04.980484","type":"function","z":"c14940d6.cf7c08","name":"extractValue","func":"msg.payload = msg.payload.split(\"\\n\")[0]  + \" \" + Math.floor(Date.now() / 1000)+\"\\r\\n\";\nmsg.headers = \"\";\nreturn msg","outputs":1,"noerr":0,"x":383,"y":406,"wires":[["a49039e1.31516","6a686365.a05d6c"]]},{"id":"a49039e1.31516","type":"debug","z":"c14940d6.cf7c08","name":"","active":true,"console":"false","complete":"true","x":631,"y":379,"wires":[]},{"id":"6a686365.a05d6c","type":"tcp out","z":"c14940d6.cf7c08","host":"12.34.56.78","port":"2003","beserver":"client","base64":false,"end":true,"name":"","x":682,"y":311,"wires":[]}]
