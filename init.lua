wifi.setmode(wifi.STATION)
station_cfg={}


station_cfg.ssid="_____" -- inserire il nome della rete wifi a cui collegarsi

station_cfg.pwd="_____" -- inserire la password della rete wifi
--- IP CONFIG (Leave blank to use DHCP) ---
--ESP8266_IP="192.168.178.143" --(Leave blank to use DHCP) ---
ESP8266_NETMASK="255.255.255.0"
ESP8266_GATEWAY="192.168.178.1"
ESP8266_IP=""
--ESP8266_NETMASK=""
--ESP8266_GATEWAY=""
--
-----------------------------------------------

--- Connect to the wifi network ---
wifi.setmode(wifi.STATION) 
--wifi.setphymode(WIFI_SIGNAL_MODE)

wifi.sta.connect()
-- rete id 2
    station_cfg.save=false
wifi.sta.config(station_cfg)
wifi.sta.connect()

if ESP8266_IP ~= "" then
 wifi.sta.setip({ip=ESP8266_IP,netmask=ESP8266_NETMASK,gateway=ESP8266_GATEWAY})
end

id_rete=1
stato=0
timer_scrivi_risultato_sul_field_1 = tmr.create()
timer_scrivi_risultato_sul_field_1:register(
    30000,
    tmr.ALARM_AUTO,
    function()
        scrivi_sul_field_1()
    end
)

mytimer = tmr.create()
mytimer:register(1000, tmr.ALARM_AUTO, function()
print("hey there") 

    if wifi.sta.getip()== nil then
            print("IP unavaiable, Waiting...")
        else
            mytimer:stop() 
            print("Connected, IP is "..wifi.sta.getip())
            print("INIZIO_FUNZIONE_1")
            lighton=0
            pin=3 -- il pin 3 � il i00 della scheda
            gpio.mode(pin,gpio.OUTPUT)            -- Assign GPIO to Output
            pin_io2=4 -- il pin io2 � l'GPIO4 ovvero quello segnato come I04 sulla scheda ESP07
            gpio.mode(pin_io2,gpio.OUTPUT)            -- Assign GPIO to Output
            timer_scrivi_risultato_sul_field_1:start()
                    print("Timer scrittura attivato con successo!")
  

    end --if wifi.sta.getip()== nil then
end) --1000, tmr.ALARM_SINGLE, function()
if not mytimer:start() then print("uh oh") end

function scrivi_sul_field_1()
     print("inizio funzione scrivi sul field 1")
	 api_key="__________________" -- inserire il valore della api key del proprio canale thingspeak
   if stato ==0 then -- se il valore è 0 allora scrivi 1 
     print("lo stato è uguale a 0")
	 
    url = "http://api.thingspeak.com/update?api_key=" .. api_key .. "&field1=1"
    print("lmodifico lo stato pari a 1")
	stato=1
    print("stato=" .. stato)
else -- se il valore è diverso da 0 allora scrivi 0 
   print("lo stato è diverso da 0. infatti è uguale a: " .. stato) 
      
      url = "http://api.thingspeak.com/update?api_key=" .. api_key .. "&field1=0"
     print("lmodifico lo stato pari a 0")      
   stato=0
      print("stato=" .. stato)  
   
end
timer_scrivi_risultato_sul_field_1:stop()
    print("provo a scrivere l url seguente: " .. url)
    http.get( url,  "", function(code, data)
            print("ho tentato di scrivere il dato  sul field 1")
            if (code == nil or code < 0) then
                print("HTTP request scrittura  nel fiel 1 failed")
               timer_scrivi_risultato_sul_field_1:start()
               print("timer riavviato")
            else --if ((code == nil or code < 0)) then
                --print("tentato di riattivare il timer 1")
                print("sono riuscito a scriveere il dato nel field 1")
                timer_scrivi_risultato_sul_field_1:start()
               print("timer riavviato")
              
             
               
            end
        end
    )
end

