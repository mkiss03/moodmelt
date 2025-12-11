# 🎈 MoodMelt Backend

Node.js + Express backend for the MoodMelt micro-therapy app, powered by OpenAI.

## Quick Start

1. **Install dependencies:**
   ```bash
   npm install
   ```

2. **Configure environment:**
   ```bash
   cp .env.example .env
   ```

   Edit `.env` and add your OpenAI API key:
   ```env
   OPENAI_API_KEY=sk-your-key-here
   PORT=4000
   ```

3. **Run the server:**
   ```bash
   npm run dev  # Development with auto-reload
   npm start    # Production
   ```

## API Endpoints

### Health Check
```
GET /health
```

### Stress Balloon - Reframe Thought
```
POST /api/microtherapy/reframe
Content-Type: application/json

{
  "thought": "Ma minden rosszul sikerült...",
  "locale": "hu"
}
```

**Response:**
```json
{
  "reframed": "Értem, hogy most úgy érzed...",
  "usage": {
    "promptTokens": 120,
    "completionTokens": 85,
    "totalTokens": 205
  }
}
```

### Thought Tornado (Coming Soon)
```
POST /api/microtherapy/tornado
```

### Mind Declutter (Coming Soon)
```
POST /api/microtherapy/declutter
```

## Tech Stack

- Express.js 4.18+
- OpenAI API (GPT-4o-mini)
- CORS, Helmet for security
- dotenv for environment variables

## Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `OPENAI_API_KEY` | Your OpenAI API key | Yes |
| `PORT` | Server port (default: 4000) | No |
| `NODE_ENV` | Environment (development/production) | No |

## Error Handling

The API returns structured error responses:

```json
{
  "error": "Error type",
  "message": "Hungarian user-friendly message",
  "details": "Technical details (dev mode only)"
}
```

## Development

```bash
# Install dependencies
npm install

# Run with auto-reload
npm run dev

# Run in production
npm start
```

## License

Private - For demonstration purposes
