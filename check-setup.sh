#!/bin/bash

echo "🎈 MoodMelt - Telepítési ellenőrző script"
echo "=========================================="
echo ""

# Check Flutter
if command -v flutter &> /dev/null; then
    echo "✅ Flutter telepítve:"
    flutter --version | head -n 1
else
    echo "❌ Flutter NINCS telepítve"
    echo "   Telepítsd innen: https://docs.flutter.dev/get-started/install"
fi

echo ""

# Check Node.js
if command -v node &> /dev/null; then
    echo "✅ Node.js telepítve:"
    node --version
else
    echo "❌ Node.js NINCS telepítve"
    echo "   Telepítsd innen: https://nodejs.org/"
fi

echo ""

# Check npm
if command -v npm &> /dev/null; then
    echo "✅ npm telepítve:"
    npm --version
else
    echo "❌ npm NINCS telepítve"
fi

echo ""

# Check if Android SDK is available
if [ -d "$ANDROID_HOME" ] || [ -d "$HOME/Android/Sdk" ]; then
    echo "✅ Android SDK telepítve"
else
    echo "⚠️  Android SDK nem található"
    echo "   Android Studio-val együtt telepíthető"
fi

echo ""

# Check if VS Code is installed
if command -v code &> /dev/null; then
    echo "✅ VS Code telepítve"
else
    echo "⚠️  VS Code nem található"
    echo "   Opcionális, de ajánlott: https://code.visualstudio.com/"
fi

echo ""
echo "=========================================="
echo "Ellenőrzés kész!"
