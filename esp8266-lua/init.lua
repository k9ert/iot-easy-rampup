wifi.setmode(wifi.STATION)
wifi.sta.config("somenetwork","somePassword")
wifi.sta.connect()

tmr.alarm(0, 1000, 1, function()
   if wifi.sta.getip()==nil then
      print("connecting to AP...")
   else
      ip, nm, gw=wifi.sta.getip()
      print("\nIP Info:\nIP Address: "..ip.." \nNetmask: "..nm.." \nGateway Addr: "..gw.."\n")
      tmr.stop(0)
      telnetServer()

      require("main")
      main()
   end
end)

function telnetServer()
    s=net.createServer(net.TCP)
    s:listen(23,function(c)
       con_std = c
       function s_output(str)
          if(con_std~=nil)
             then con_std:send(str)
          end
       end
       node.output(s_output, 0)
       c:on("receive",function(c,l)
          node.input(l)
       end)
       c:on("disconnection",function(c)
          con_std = nil
          node.output(nil)
       end)
    end)
end
