#!/bin/bash

echo "📱 MoodMelt Flutter App indítása..."
echo ""

# Check if we're in the right directory
if [ ! -f "moodmelt_app/pubspec.yaml" ]; then
    echo "❌ Hiba: Nem a MoodMelt projekt mappájában vagy!"
    echo "   Futtasd ezt a scriptet a moodmelt/ mappából."
    exit 1
fi

# Navigate to flutter app
cd moodmelt_app

# Check if dependencies are installed
if [ ! -d ".dart_tool" ]; then
    echo "📦 Flutter függőségek telepítése..."
    flutter pub get
    echo ""
fi

# Check for available devices
echo "🔍 Elérhető eszközök:"
flutter devices
echo ""

# Prompt user about backend URL configuration
echo "⚠️  FONTOS: Ellenőrizd a backend URL-t!"
echo ""
echo "Hol tesztelsz?"
echo "1) Android Emulátor    (használj: http://10.0.2.2:4000/api/microtherapy)"
echo "2) iOS Simulator       (használj: http://localhost:4000/api/microtherapy)"
echo "3) Fizikai eszköz      (használd a géped IP címét, pl: http://192.168.1.100:4000/api/microtherapy)"
echo ""
echo "Fájl: lib/features/microtherapy/data/microtherapy_api.dart"
echo "Változó: baseUrl"
echo ""
read -p "Nyomd meg Enter-t, ha beállítottad a helyes URL-t..."

echo ""
echo "🚀 Flutter app indítása..."
echo "   Ha több eszköz is van, válaszd ki az egyiket."
echo "   Hot reload: 'r' billentyű"
echo "   Hot restart: 'R' billentyű"
echo "   Kilépés: 'q' billentyű"
echo ""

flutter run
