#!/bin/bash

echo "🎈 MoodMelt Backend indítása..."
echo ""

# Check if we're in the right directory
if [ ! -f "moodmelt_backend/package.json" ]; then
    echo "❌ Hiba: Nem a MoodMelt projekt mappájában vagy!"
    echo "   Futtasd ezt a scriptet a moodmelt/ mappából."
    exit 1
fi

# Navigate to backend
cd moodmelt_backend

# Check if node_modules exists
if [ ! -d "node_modules" ]; then
    echo "📦 node_modules nem található, npm install futtatása..."
    npm install
    echo ""
fi

# Check if .env exists
if [ ! -f ".env" ]; then
    echo "⚠️  .env fájl nem található!"
    echo "   Másolom a .env.example-t .env-be..."
    cp .env.example .env
    echo ""
    echo "⚠️  FONTOS: Nyisd meg a .env fájlt és add meg az OpenAI API kulcsod!"
    echo "   nano .env"
    echo ""
    read -p "Nyomd meg Enter-t, ha beállítottad az API kulcsot..."
fi

echo ""
echo "🚀 Backend indítása port 4000-en..."
echo "   Ctrl+C -vel állíthatod meg"
echo ""

npm run dev
