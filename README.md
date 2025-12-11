# 🎈 MoodMelt

**Tagline:** *Melt away your stress in 2 minutes.*

MoodMelt is a micro-therapy mobile app that helps you release daily stress and overthinking through 1-3 minute playful, visually delightful mini-exercises. It's not therapy, it doesn't diagnose—it's quick, casual, but empathetic emotional support.

---

## 📱 App Concept

### Target Audience
- **Age:** 18-35 year old young adults
- **Characteristics:**
  - Experiencing high stress and anxiety
  - Overwhelmed (studies, work, social media overstimulation)
  - Don't want 20-30 minute meditation sessions
  - Looking for something quick, creative, and cool that actually helps

### Tone of Voice
- Informal, friendly, direct (Hungarian: tegezős)
- Modern, TikTok/Discord generation compatible, but not childish
- Not esoteric, not "guru-like"
- **Never diagnoses** (no "you're depressed", "you have an anxiety disorder", etc.)

---

## 🎨 Brand & Design

### Visual Identity
- **Name:** MoodMelt = mood melts, softening tension
- **Visual style:** Soft shapes, "milky" color gradients, flowing forms

### Colors
- **Primary:** Purple-Pink gradient (`#A855F7` → `#EC4899`)
- **Secondary Blue:** `#38BDF8` (calming)
- **Secondary Green:** `#22C55E` (peaceful)
- **Background:**
  - Light mode: `#F9FAFB`
  - Dark mode (future): `#020617` with translucent purple/pink elements

### Typography
- **Headings:** Poppins (semi-bold, rounded vibe)
- **Body:** Roboto / Inter

### Logo Concept
- Drop-shaped, melting form with a sparkle or smiling face
- Simple, flat logo suitable for App Store/Play Store icon
- Purple-pink gradient

---

## ✨ Features (MVP)

### 1. Onboarding (Mini Questionnaire)
- What's your main goal? (reduce stress, manage anxiety, improve sleep, more calm)
- How overwhelmed do you feel on a 1-5 scale?

### 2. Home / Mood Dashboard
- Daily mood question: "How do you feel today?"
  - Emoji + slider
- Recommended micro-therapy module based on mood
- List of all 4 modules

### 3. Micro-Therapy Modules (4 in MVP)

#### 🎈 Stress Balloon
Write a negative thought into a "stress balloon", get AI reframing, balloon floats away

#### 🌪️ Thought Tornado
"Thought storm" with AI-generated negative thought cards that you can swipe away

#### 🧹 Mind Declutter
"Mental tidying" - AI lists what drained/gave you energy, checkable list

#### 🧘 Box Breathing Melt
Animated breathing exercise with a "melting square" (4-4-4-4 seconds)

### 4. History / Progress
- Streak counter (days in a row)
- List of recently used modules
- **Note:** MVP uses local storage only, no authentication

### 5. Settings
- Language selection (HU/EN - future phase)
- Privacy policy link

---

## 🏗️ Project Structure

```
moodmelt/
├── moodmelt_app/          # Flutter frontend
│   ├── lib/
│   │   ├── core/
│   │   │   ├── theme/
│   │   │   │   └── app_theme.dart
│   │   │   └── widgets/
│   │   │       ├── moodmelt_button.dart
│   │   │       └── mood_slider.dart
│   │   ├── features/
│   │   │   ├── onboarding/
│   │   │   │   └── presentation/
│   │   │   │       └── onboarding_screen.dart
│   │   │   ├── home/
│   │   │   │   └── presentation/
│   │   │   │       └── home_screen.dart
│   │   │   └── microtherapy/
│   │   │       ├── domain/
│   │   │       │   └── microtherapy_session.dart
│   │   │       ├── application/
│   │   │       │   └── stress_balloon_controller.dart
│   │   │       ├── data/
│   │   │       │   └── microtherapy_api.dart
│   │   │       └── presentation/
│   │   │           ├── stress_balloon_screen.dart
│   │   │           ├── thought_tornado_screen.dart
│   │   │           ├── mind_declutter_screen.dart
│   │   │           └── box_breathing_screen.dart
│   │   ├── routes/
│   │   │   └── app_router.dart
│   │   └── main.dart
│   └── pubspec.yaml
│
└── moodmelt_backend/      # Node.js + Express backend
    ├── index.js
    ├── package.json
    ├── .env.example
    └── .gitignore
```

---

## 🚀 Getting Started

### Prerequisites
- **Flutter:** 3.0+ ([Install Flutter](https://flutter.dev/docs/get-started/install))
- **Node.js:** 18+ ([Install Node.js](https://nodejs.org/))
- **OpenAI API Key:** Get one at [platform.openai.com](https://platform.openai.com)

---

## 🖥️ Backend Setup

### 1. Navigate to backend directory
```bash
cd moodmelt_backend
```

### 2. Install dependencies
```bash
npm install
```

### 3. Configure environment
```bash
cp .env.example .env
```

Edit `.env` and add your OpenAI API key:
```env
OPENAI_API_KEY=sk-your-api-key-here
PORT=4000
NODE_ENV=development
```

### 4. Start the server
```bash
# Development mode (with auto-reload)
npm run dev

# Production mode
npm start
```

The server will start on `http://localhost:4000`

### Backend Endpoints

#### Health Check
```
GET /health
```

#### Stress Balloon - Reframe Thought
```
POST /api/microtherapy/reframe
Content-Type: application/json

{
  "thought": "Ma minden rosszul sikerült...",
  "locale": "hu"
}
```

Response:
```json
{
  "reframed": "Értem, hogy most úgy érzed, minden elment... [AI response]",
  "usage": {
    "promptTokens": 120,
    "completionTokens": 85,
    "totalTokens": 205
  }
}
```

#### Thought Tornado (Placeholder)
```
POST /api/microtherapy/tornado
```

#### Mind Declutter (Placeholder)
```
POST /api/microtherapy/declutter
```

---

## 📱 Flutter App Setup

### 1. Navigate to app directory
```bash
cd moodmelt_app
```

### 2. Install dependencies
```bash
flutter pub get
```

### 3. Update backend URL (if needed)
Edit `lib/features/microtherapy/data/microtherapy_api.dart`:
```dart
static const String baseUrl = 'http://localhost:4000/api/microtherapy';
// For Android emulator use: http://10.0.2.2:4000/api/microtherapy
// For iOS simulator use: http://localhost:4000/api/microtherapy
// For physical device use: http://YOUR_COMPUTER_IP:4000/api/microtherapy
```

### 4. Run the app
```bash
flutter run
```

---

## 🎯 Tech Stack

### Frontend (Flutter)
- **Framework:** Flutter 3.x
- **State Management:** Riverpod 2.4+
- **HTTP Client:** Dio 5.4+
- **Routing:** go_router 12.1+
- **Fonts:** Google Fonts (Poppins, Roboto)

### Backend (Node.js)
- **Runtime:** Node.js 18+
- **Framework:** Express.js 4.18+
- **AI:** OpenAI API (GPT-4o-mini)
- **Security:** Helmet.js, CORS
- **Environment:** dotenv

---

## 🎨 Design System

### MoodMelt Theme Colors
```dart
Primary Purple:  #A855F7
Primary Pink:    #EC4899
Secondary Blue:  #38BDF8
Secondary Green: #22C55E
Background:      #F9FAFB
```

### Gradient
```dart
LinearGradient(
  colors: [Color(0xFFA855F7), Color(0xFFEC4899)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
)
```

---

## 🤖 OpenAI Integration

### Global System Prompt
```
You are MoodMelt, a warm, empathetic, playful mental well-being assistant.
You help users release everyday stress and overthinking with short, friendly, micro-interventions.
You are not a doctor or therapist and you never diagnose or name mental disorders.

Style rules:
- Answer in Hungarian, informal tegezős style.
- Be short and to the point (max 3–5 sentences).
- Use simple, everyday language.
- Validate the user's feelings, then offer a gentle, realistic reframe or small action step.
- Never say you are an AI model. Just talk like a supportive friend.
```

### Model Configuration
- **Model:** `gpt-4o-mini` (cost-effective, fast)
- **Temperature:** 0.7 (balanced creativity)
- **Max Tokens:** 300 (keeps responses concise)

---

## 📦 Current Implementation Status

### ✅ Completed
- [x] Flutter project structure with feature-based architecture
- [x] MoodMelt brand theme (colors, fonts, gradients)
- [x] App routing with go_router
- [x] Onboarding flow (3 screens)
- [x] Home screen with mood dashboard
- [x] Mood slider widget
- [x] **Fully implemented Stress Balloon module:**
  - Beautiful balloon animation (scale, opacity, position)
  - Text input for thoughts
  - API integration with backend
  - Riverpod state management
  - Error handling
  - Result display with reframed thought
- [x] Node.js backend with Express
- [x] OpenAI integration
- [x] `/api/microtherapy/reframe` endpoint

### 🚧 To Do (Future Enhancements)
- [ ] Complete Thought Tornado module
- [ ] Complete Mind Declutter module
- [ ] Complete Box Breathing module
- [ ] Local storage for history/streak
- [ ] Settings screen
- [ ] Dark mode theme
- [ ] Localization (EN/HU)
- [ ] Animation polish and micro-interactions
- [ ] Unit and widget tests
- [ ] Backend tests
- [ ] Production deployment guide

---

## 🧪 Testing the App

### Test Stress Balloon Flow

1. **Start the backend:**
   ```bash
   cd moodmelt_backend
   npm run dev
   ```

2. **Run the Flutter app:**
   ```bash
   cd moodmelt_app
   flutter run
   ```

3. **Navigate through the app:**
   - Complete the onboarding flow
   - On the home screen, adjust your mood with the slider
   - Tap on "Stress Balloon" card
   - Enter a thought like: "Ma minden rosszul sikerült, és úgy érzem, nem bírok többet"
   - Tap "Engedd el"
   - Watch the balloon animation
   - See the AI-reframed response

### Expected Result
The app should:
- Animate the balloon (scale up, fade out, move up)
- Show loading state during API call
- Display empathetic, reframed response from OpenAI
- Show a supportive message: "Ezt bármikor megteheted. Nem vagy egyedül."

---

## 🔒 Privacy & Ethics

- **No diagnosis:** The app never diagnoses mental health conditions
- **Local-first:** MVP stores all data locally, no account required
- **Transparent:** Users understand this is AI-assisted, not professional therapy
- **Empathetic:** Tone is always supportive, never judgmental

---

## 📄 License

This project is private and for demonstration purposes.

---

## 🙏 Credits

- **Design Concept:** MoodMelt product specification
- **AI Partner:** OpenAI GPT-4o-mini
- **Fonts:** Google Fonts (Poppins, Roboto)

---

## 📞 Support

For questions or issues, please contact the development team.

---

**Built with 💜 for mental well-being**
