const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const dotenv = require('dotenv');
const OpenAI = require('openai');

// Load environment variables
dotenv.config();

// Initialize Express app
const app = express();
const PORT = process.env.PORT || 4000;

// Initialize OpenAI
const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY,
});

// Middleware
app.use(helmet());
app.use(cors());
app.use(express.json());

// Request logging middleware
app.use((req, res, next) => {
  console.log(`${new Date().toISOString()} - ${req.method} ${req.path}`);
  next();
});

// Global MoodMelt system prompt
const MOODMELT_SYSTEM_PROMPT = `You are MoodMelt, a warm, empathetic, playful mental well-being assistant.
You help users release everyday stress and overthinking with short, friendly, micro-interventions.
You are not a doctor or therapist and you never diagnose or name mental disorders.

Style rules:
- Answer in Hungarian, informal tegezős style.
- Be short and to the point (max 3–5 sentences).
- Use simple, everyday language.
- Validate the user's feelings, then offer a gentle, realistic reframe or small action step.
- Never say you are an AI model. Just talk like a supportive friend.`;

// Health check endpoint
app.get('/health', (req, res) => {
  res.json({ status: 'ok', service: 'MoodMelt Backend', version: '1.0.0' });
});

// POST /api/microtherapy/reframe - Stress Balloon
app.post('/api/microtherapy/reframe', async (req, res) => {
  try {
    const { thought, locale = 'hu' } = req.body;

    if (!thought || thought.trim().length === 0) {
      return res.status(400).json({
        error: 'Thought cannot be empty',
        message: 'Kérlek, írj be egy gondolatot.',
      });
    }

    // Construct the user prompt for Stress Balloon
    const userPrompt = `A felhasználó ezt írta a "Stress Balloon" modulban (gondolat, ami feszíti):
"${thought}"

Feladatod:
1. Röviden tükrözd vissza az érzését, empatikusan.
2. Adj egy kíméletes kognitív újrakeretezést (reframing).
3. Max 3–4 mondatban válaszolj, tegezve.`;

    // Call OpenAI API
    const completion = await openai.chat.completions.create({
      model: 'gpt-4o-mini',
      messages: [
        { role: 'system', content: MOODMELT_SYSTEM_PROMPT },
        { role: 'user', content: userPrompt },
      ],
      temperature: 0.7,
      max_tokens: 300,
    });

    const reframed = completion.choices[0]?.message?.content?.trim();

    if (!reframed) {
      throw new Error('No response from OpenAI');
    }

    res.json({
      reframed,
      usage: {
        promptTokens: completion.usage?.prompt_tokens,
        completionTokens: completion.usage?.completion_tokens,
        totalTokens: completion.usage?.total_tokens,
      },
    });
  } catch (error) {
    console.error('Error in /api/microtherapy/reframe:', error);

    if (error.code === 'ENOTFOUND' || error.code === 'ETIMEDOUT') {
      return res.status(503).json({
        error: 'Service unavailable',
        message: 'Nem sikerült kapcsolódni az AI szolgáltatáshoz.',
      });
    }

    if (error.status === 401) {
      return res.status(500).json({
        error: 'API configuration error',
        message: 'A szerver konfigurációs hibája. Kérlek, jelezd a fejlesztőknek.',
      });
    }

    res.status(500).json({
      error: 'Internal server error',
      message: 'Hiba történt a kérés feldolgozása során.',
      details: process.env.NODE_ENV === 'development' ? error.message : undefined,
    });
  }
});

// POST /api/microtherapy/tornado - Thought Tornado (placeholder)
app.post('/api/microtherapy/tornado', async (req, res) => {
  try {
    const { moodLevel, locale = 'hu' } = req.body;

    const userPrompt = `A felhasználó hangulat szintje: ${moodLevel}/5.
Generálj 3-5 gyakori negatív gondolatot, ami ilyen hangulatban jellemző lehet.
Listázd őket röviden, egyszerűen, 1-1 mondatban.`;

    const completion = await openai.chat.completions.create({
      model: 'gpt-4o-mini',
      messages: [
        { role: 'system', content: MOODMELT_SYSTEM_PROMPT },
        { role: 'user', content: userPrompt },
      ],
      temperature: 0.8,
      max_tokens: 300,
    });

    const thoughts = completion.choices[0]?.message?.content?.trim();

    res.json({
      thoughts: thoughts?.split('\n').filter(t => t.trim()),
      summary: 'Ezek a gondolatok nem tények, csak az agyadban feltűnő zajok.',
    });
  } catch (error) {
    console.error('Error in /api/microtherapy/tornado:', error);
    res.status(500).json({
      error: 'Internal server error',
      message: 'Hiba történt a kérés feldolgozása során.',
    });
  }
});

// POST /api/microtherapy/declutter - Mind Declutter (placeholder)
app.post('/api/microtherapy/declutter', async (req, res) => {
  try {
    const { locale = 'hu' } = req.body;

    const userPrompt = `Generálj két listát a "Mind Declutter" modulhoz:
1. "Mi vitt el energiát ma?" - 3 gyakori energiavampír dolog
2. "Mi adott energiát ma?" - 3 gyakori feltöltő dolog

Formázd egyszerűen, rövid mondatokban.`;

    const completion = await openai.chat.completions.create({
      model: 'gpt-4o-mini',
      messages: [
        { role: 'system', content: MOODMELT_SYSTEM_PROMPT },
        { role: 'user', content: userPrompt },
      ],
      temperature: 0.7,
      max_tokens: 300,
    });

    const response = completion.choices[0]?.message?.content?.trim();

    res.json({
      suggestions: response,
      summary: 'Figyeld meg, mi szívja el és mi tölti fel az energiádat.',
    });
  } catch (error) {
    console.error('Error in /api/microtherapy/declutter:', error);
    res.status(500).json({
      error: 'Internal server error',
      message: 'Hiba történt a kérés feldolgozása során.',
    });
  }
});

// 404 handler
app.use((req, res) => {
  res.status(404).json({
    error: 'Not found',
    message: 'A kért végpont nem található.',
  });
});

// Start server
app.listen(PORT, () => {
  console.log(`\n🎈 MoodMelt Backend is running on port ${PORT}`);
  console.log(`📍 Health check: http://localhost:${PORT}/health`);
  console.log(`🧠 OpenAI API Key: ${process.env.OPENAI_API_KEY ? '✓ Configured' : '✗ Missing'}\n`);
});

module.exports = app;
