# ESP8266 WiFi Connection and ThingSpeak Integration

Questo progetto permette di configurare un modulo ESP8266 per connettersi a una rete WiFi e inviare dati al servizio **ThingSpeak**. Il modulo alterna il valore di un campo (field) tra `0` e `1` a intervalli regolari utilizzando un timer. In questo modo è possibile verificare quando non si è in casa se è venuta a mancare l'alimentazione elettrica e agire di conseguenza per limitare i disagi.

---

## Funzionalità principali

- **Connessione WiFi**: Configura il modulo ESP8266 per connettersi a una rete WiFi specificata.
- **Configurazione IP**: Supporta sia indirizzamenti IP statici che dinamici (DHCP).
- **Integrazione con ThingSpeak**: Invia i dati al servizio ThingSpeak utilizzando un'API.
- **Gestione GPIO**: Configura i pin GPIO per controllare dispositivi esterni.
- **Timer**: Implementa un timer per inviare dati a ThingSpeak ogni 30 secondi.

---

## Requisiti

- Modulo **ESP8266** (es. NodeMCU o ESP-07).
- Alimentazione adeguata per il modulo ESP8266.
- Accesso alla rete WiFi con:
  - Nome della rete (**SSID**).
  - Password della rete (**Password**).
- Account ThingSpeak con una chiave API valida.

---

## Come utilizzare il codice

1. **Installazione dell'ambiente di sviluppo**:
   - Utilizza l'ambiente NodeMCU Lua Firmware sul tuo ESP8266.
   - Flasha il firmware Lua sul modulo ESP8266 (se necessario).

2. **Configurazione WiFi**:
   - Modifica il parametro `station_cfg.ssid` con il nome della rete WiFi.
   - Modifica il parametro `station_cfg.pwd` con la password della rete WiFi.

3. **Configurazione IP**:
   - Per utilizzare un indirizzo IP statico, specifica i valori di:
     - `ESP8266_IP`
     - `ESP8266_NETMASK`
     - `ESP8266_GATEWAY`
   - Lascia vuoti questi campi per utilizzare DHCP.

4. **Configurazione ThingSpeak**:
   - Inserisci la tua **API Key** del canale THINGSPEAK al posto di `__________________` nella variabile `url`.

5. **Carica il codice**:
   - Carica il codice sul modulo ESP8266 utilizzando un IDE compatibile (es. ESPlorer o NodeMCU PyFlasher).

6. **Avvio**:
   - Una volta avviato, il modulo si connetterà alla rete WiFi e inizierà a inviare dati al campo specificato su ThingSpeak.

---

## Dettagli del codice

### Configurazione iniziale
Il modulo è configurato per la modalità **STATION**:
```lua
wifi.setmode(wifi.STATION)
