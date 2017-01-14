-- shamelessly copied
-- https://github.com/nodemcu/nodemcu-firmware/blob/master/lua_modules/ds18b20/ds18b20-example.lua

t = require("ds18b20")

-- ESP-01 GPIO Mapping
gpio0 = 3
gpio2 = 4

t.setup(gpio0)
addrs = t.addrs()
if (addrs ~= nil) then
  print("Total DS18B20 sensors: "..table.getn(addrs))
end

-- Just read temperature
temp = t.read()
print("Temperature: "..temp.."'C")


cu2=net.createConnection(net.TCP,0)

cu2:on("connection", function() 
    print("connected") 
    text = "zfs.es.test.temp "..temp.."\r\n"
    print(text)
    cu2:send(text)
    cu2:close()
  end)
cu2:connect(2003, "192.168.178.45")

-- Don't forget to release it after use
t = nil
ds18b20 = nil
package.loaded["ds18b20"]=nil

