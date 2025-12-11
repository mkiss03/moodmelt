# 🎈 MoodMelt - Telepítés és Tesztelés

## 📋 Lépések a teszteléshez

---

## 1️⃣ **Előfeltételek ellenőrzése**

Futtasd ezt a parancsot a projekt mappájában:

```bash
./check-setup.sh
```

### Mit kell telepítened:

#### **A) Flutter (kötelező)**
1. Menj ide: https://docs.flutter.dev/get-started/install
2. Válaszd ki az operációs rendszeredet (Windows/Mac/Linux)
3. Kövesd a telepítési lépéseket
4. Ellenőrizd: `flutter doctor`

#### **B) Node.js (kötelező)**
1. Menj ide: https://nodejs.org/
2. Töltsd le a **LTS verzió**t (18.x vagy újabb)
3. Telepítsd
4. Ellenőrizd: `node --version` és `npm --version`

#### **C) Android Studio vagy emulátor (kötelező a teszteléshez)**

**Opció 1: Android Studio (teljes csomag)**
1. Töltsd le: https://developer.android.com/studio
2. Telepítés után nyisd meg
3. Tools → SDK Manager → SDK Tools tab
4. Pipáld ki: **Android SDK Command-line Tools**
5. Apply → OK

**Opció 2: Csak Android SDK (könnyebb)**
```bash
flutter doctor --android-licenses
```

#### **D) VS Code (ajánlott, de opcionális)**
1. Töltsd le: https://code.visualstudio.com/
2. Telepítsd ezeket az extension-öket:
   - Flutter
   - Dart
   - Thunder Client (API teszteléshez)

---

## 2️⃣ **Projekt előkészítése**

### A) Backend telepítése

```bash
# 1. Menj a backend mappába
cd moodmelt_backend

# 2. Telepítsd a függőségeket
npm install

# 3. Hozd létre az environment fájlt
cp .env.example .env

# 4. Nyisd meg a .env fájlt és add meg az OpenAI API kulcsod
# nano .env   (vagy bármilyen szövegszerkesztővel)
```

A `.env` fájlban cseréld ki ezt:
```env
OPENAI_API_KEY=your_openai_api_key_here
```

Erre:
```env
OPENAI_API_KEY=sk-proj-xxxxx...  # A te valódi OpenAI kulcsod
```

**OpenAI API kulcs beszerzése:**
1. Menj ide: https://platform.openai.com/api-keys
2. Regisztrálj vagy jelentkezz be
3. Create new secret key
4. Másold ki és ragaszd be a .env fájlba

### B) Flutter app előkészítése

```bash
# 1. Menj a Flutter mappába
cd ../moodmelt_app

# 2. Telepítsd a függőségeket
flutter pub get

# 3. Ellenőrizd, hogy minden rendben van-e
flutter doctor
```

---

## 3️⃣ **Android emulátor indítása**

### Opció A: Android Studio-val

1. Nyisd meg az **Android Studio**-t
2. Jobb felül: **Device Manager** (telefon ikon)
3. Ha nincs emulátorod:
   - **Create Device**
   - Válassz egy telefont (pl. Pixel 7)
   - Válassz rendszert (pl. **Tiramisu - API 33**)
   - Finish
4. Kattints a **Play** gombra az emulátor mellett

### Opció B: Terminálból (gyorsabb)

```bash
# Listázd ki az elérhető emulátorokat
flutter emulators

# Indítsd el az egyiket (pl. ha a neve "Pixel_7")
flutter emulators --launch Pixel_7

# Vagy Android Studio emulátor indítása névvel
emulator -avd Pixel_7
```

### Opció C: Fizikai telefon (ajánlott, ha van)

1. Kapcsold be a **Developer Options**-t:
   - Beállítások → Névjegy → Sorozatszám 7x koppintás
2. Beállítások → Developer Options → **USB debugging** BE
3. Csatlakoztasd USB-vel a géphez
4. Engedélyezd az USB debugging-ot a telefonon

Ellenőrzés:
```bash
flutter devices
```

Látnod kell a telefonod vagy az emulátort a listában.

---

## 4️⃣ **Backend indítása**

**Nyiss egy új terminált** és:

```bash
# Menj a backend mappába
cd moodmelt_backend

# Indítsd el a szervert (development módban, auto-reload-dal)
npm run dev
```

✅ Ha jól működik, ezt látod:
```
🎈 MoodMelt Backend is running on port 4000
📍 Health check: http://localhost:4000/health
🧠 OpenAI API Key: ✓ Configured
```

**NE zárd be ezt a terminált!** A backend most fut a háttérben.

---

## 5️⃣ **Backend URL beállítása**

### Ha fizikai telefonon tesztelsz:

1. Tudnod kell a géped IP címét:

**Windows:**
```bash
ipconfig
```
Keresd ezt: `IPv4 Address: 192.168.x.x`

**Mac/Linux:**
```bash
ifconfig | grep inet
# vagy
ip addr show
```

2. Nyisd meg ezt a fájlt:
```
moodmelt_app/lib/features/microtherapy/data/microtherapy_api.dart
```

3. Változtasd meg:
```dart
static const String baseUrl = 'http://localhost:4000/api/microtherapy';
```

Erre (használd a saját IP-d):
```dart
// Fizikai telefon esetén:
static const String baseUrl = 'http://192.168.1.100:4000/api/microtherapy';

// Android emulátor esetén:
static const String baseUrl = 'http://10.0.2.2:4000/api/microtherapy';

// iOS Simulator esetén:
static const String baseUrl = 'http://localhost:4000/api/microtherapy';
```

---

## 6️⃣ **Flutter app indítása**

**Nyiss egy ÚJ terminált** (a backend terminált hagyd futni!):

```bash
# Menj a Flutter mappába
cd moodmelt_app

# Indítsd el az appot
flutter run
```

### Mi fog történni:

1. Flutter lefordítja az appot (első alkalommal 2-3 perc)
2. Telepíti az eszközödre/emulátorra
3. Elindul az app

### Ha több eszköz is elérhető:

```bash
# Listázd az eszközöket
flutter devices

# Válassz egyet
flutter run -d <device_id>

# Például:
flutter run -d emulator-5554
```

---

## 7️⃣ **App tesztelése**

### Navigáció az appban:

1. **Splash/Onboarding:**
   - Koppints végig a 3 onboarding képernyőn
   - Válassz egy célt (pl. "Kevesebb stresszt szeretnék")
   - Állítsd be a túlterheltség szintet
   - "Kezdjük" gomb

2. **Home képernyő:**
   - Állítsd be a hangulatodat az emoji slider-rel
   - Nézd meg az ajánlott modult
   - Görgess le, lásd mind a 4 modult

3. **Stress Balloon tesztelés:**
   - Koppints a "Stress Balloon 🎈" kártyára
   - Írj be egy gondolatot, pl:
     ```
     Ma minden rosszul sikerült, és úgy érzem, nem bírok többet
     ```
   - Nyomd meg az "Engedd el" gombot
   - Nézd a lufi animációt (felfújódik, elhalványul, felfelé száll)
   - Kb. 2-5 másodperc múlva látod az AI válaszát

### Várható eredmény:

✅ Lufi szépen animálódik
✅ Megjelenik egy empatikus válasz (pl. "Értem, hogy most úgy érzed...")
✅ Alul egy kis üzenet: "Ezt bármikor megteheted. Nem vagy egyedül."

---

## 🐛 **Hibakeresés**

### A) Backend nem indul

**Hiba:** `Error: Cannot find module 'express'`
```bash
cd moodmelt_backend
rm -rf node_modules
npm install
```

**Hiba:** `OpenAI API Key: ✗ Missing`
- Ellenőrizd a `.env` fájlt
- Biztos, hogy a `.env` a `moodmelt_backend/` mappában van?

### B) Flutter build hiba

**Hiba:** `flutter: command not found`
- Flutter nincs telepítve vagy nincs a PATH-ban
- Futtasd: `flutter doctor` és kövesd az instrukciókat

**Hiba:** Android license nem elfogadva
```bash
flutter doctor --android-licenses
```
Nyomd meg az `y`-t mindenhol.

### C) App nem kapcsolódik a backendhez

**Hiba:** `Failed to connect to server`

1. Ellenőrizd, hogy a backend fut:
   ```bash
   curl http://localhost:4000/health
   ```
   Válasz: `{"status":"ok",...}`

2. Fizikai telefon esetén:
   - Győződj meg, hogy a telefon és a gép **ugyanazon a WiFi hálózaton** van
   - Ellenőrizd a tűzfalat (Windows Firewall, Mac Firewall)
   - Próbáld böngészőből: `http://192.168.x.x:4000/health`

3. Android emulátor esetén:
   - Használd: `http://10.0.2.2:4000` (NEM `localhost`)

### D) UI nem jelenik meg rendesen

**Hiba:** Nem látszanak a Poppins vagy Roboto betűk

Ez várható! A `google_fonts` package automatikusan letölti őket, de:
- Az első indításkor lehet, hogy a rendszer alapértelmezett fontja látszik
- Internetkapcsolat kell a font letöltéséhez
- A következő indításnál már cache-ből jönnek

---

## 🎯 **Hot Reload tesztelése**

Miközben az app fut, próbáld ki:

1. Módosíts valamit a kódban (pl. változtasd meg a színt)
2. Mentsd el a fájlt
3. A terminálban nyomd meg: **`r`** (Hot Reload)
4. Az app azonnal frissül, az állapotot megtartva

Hasznos billentyűk:
- `r` - Hot reload
- `R` - Hot restart (újraindítja az egész appot)
- `q` - Kilépés
- `h` - Súgó

---

## 📱 **Gyors indítás összefoglalva**

### Két terminálra lesz szükséged:

**Terminál 1 (Backend):**
```bash
cd moodmelt_backend
npm run dev
# Hagyd futni!
```

**Terminál 2 (Flutter):**
```bash
cd moodmelt_app
flutter run
# Vagy Android Studio-ból: Run gomb
```

---

## 🎉 **Sikeres tesztelés checklist:**

- [ ] Backend elindul és kiírja: ✓ OpenAI API Key Configured
- [ ] Flutter app települ az eszközre
- [ ] Onboarding végigkattintható
- [ ] Home képernyő megjelenik emoji slider-rel
- [ ] Stress Balloon megnyílik
- [ ] Gondolat beírása után a lufi animálódik
- [ ] 2-5 másodperc múlva megjelenik az AI válasz
- [ ] "Újra próbálom" gomb működik

---

## 💡 **Tippek**

### VS Code-ból való futtatás:
1. Nyisd meg a `moodmelt_app` mappát VS Code-ban
2. Jobb alsó sarokban válaszd ki az eszközt
3. F5 vagy Run → Start Debugging

### Android Studio-ból való futtatás:
1. Open Project → Válaszd ki a `moodmelt_app` mappát
2. Fent válassz eszközt a dropdown-ból
3. Zöld Play gomb (Run)

### Két backend példány ne fusson:
```bash
# Linux/Mac:
lsof -ti:4000 | xargs kill -9

# Windows:
netstat -ano | findstr :4000
taskkill /PID <PID> /F
```

---

## 📞 Segítség

Ha elakadtál:
1. Ellenőrizd a backend terminál outputját
2. Ellenőrizd a Flutter terminál hibaüzeneteit
3. Futtasd: `flutter doctor -v` és nézd meg a problémákat
4. Backend teszt: `curl http://localhost:4000/health`

---

**Jó tesztelést! 🎈💜**
