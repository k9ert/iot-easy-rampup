function main()


tmr.alarm(0, 10000, 1, function()
   dofile("ds18b20-example.lua")
end)

end
