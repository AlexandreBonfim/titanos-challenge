# TitanOS Technical Challenge

This repository implements the TitanOS backend challenge using a clean, test-driven Ruby on Rails 8 API architecture. The service ingests streaming metadata (movies, TV shows, channels, programs), exposes content discovery endpoints, enables user favorites, and supports cross-type search. Eveything built with performance, maintainability, and clarity in mind.

## 🚀 Features Delivered

- ✅ Fully containerized Rails API with Docker
- ✅ JSON importer (Streams::Importer) to parse & persist all content types
- ✅ Normalized domain models: Movie, TvShow, Season, Episode, Channel, ChannelProgram, App, Availability, WatchEvent, FavoriteApp
- ✅ Endpoints for all content types (show, list with filters, search)
- ✅ Favorites system
    - Favorite Apps (POST + GET sorted by position)
    - Favorite Channel Programs (sorted by watched seconds)
- ✅ Watch time tracking for Channel Programs
- ✅ Robust TDD suite
    - Model tests
    - Importer tests
    - Request tests per endpoint
- ✅ Error handling layer (404, missing params, validation errors)

## 🔮 Future Enhancements

- ⚡ Caching layer per country/type for contents#index
- 📈 Observability: structured logs + request metrics
- 🛡 Authentication layer (JWT or API keys)
- 🔁 Soft-delete or versioning strategy on imported content

## 🧰 Tech Stack

Backend: Ruby on Rails 8, PostgreSQL, ActiveRecord
Infrastructure: Docker
Testing: RSpec, FactoryBot


📦 Project Structure

```bash
app/
├── controllers/api/v1/     # versioned API
├── models/                 # domain models
├── services/streams/       # importer logic
└── serializers (future)
spec/
├── models/                 # model specs
├── requests/api/v1/        # endpoint specs
└── fixtures/               # sample JSON
db/
└── streams_data.json       # challenge dataset
```


This structure is intentionally simple and scalable.

## ⚙️ Local Setup

### 1. Clone the repository
```bash
git clone https://github.com/AlexandreBonfim/titanos-challenge.git
cd titanos-challenge
```

### 2. Copy the challenge dataset
Already included at:
```bash
db/streams_data.json
```

### 3. Local Ruby-only setup (optional)
```bash
bundle install
bin/rails db:create db:migrate
bin/rails streams:import
bin/rails server
```

### CORS configuration

The API ships with permissive CORS (any origin) so Swagger UI and external clients can call it out of the box. To tighten it up in specific environments, set the `CORS_ORIGINS` environment variable (comma-separated list of origins) before booting Rails.


API runs at:
👉 http://localhost:3000

## 🐳 Run with Docker (recommended)

Requires Docker & Docker Compose.

### 1. Build containers
```bash
docker-compose build
```

### 2. Run the stack
```bash
docker-compose up
```

Rails API → http://localhost:3000

### 3. DB setup & data import
```bash
docker-compose run --rm development bin/rails db:migrate
docker-compose run --rm development bin/rails streams:import
```


Stop services:
```bash

docker-compose down
```

## 🧪 Running Tests
All tests (models, services, requests):

```bash
bundle exec rspec
```

Or inside Docker:

```bash
docker-compose run --rm development bundle exec rspec
```

## 🧭 API Overview
`GET /api/v1/contents`

List all content available in a given country.

Parameters:

| Name | Type | Required | Notes |
| --- | --- | --- | --- |
| `country` | string | yes | Market code (e.g. `gb`) |
| `type` | string | no | `movie`, `tv_show`, `season`, `episode`, `channel`, `channel_program` |

Example:
```bash
/api/v1/contents?country=gb&type=movie
```
--- 
<br />

`GET /api/v1/movies/:id`    
`GET /api/v1/tv_shows/:id`  
`GET /api/v1/seasons/:id`   
`GET /api/v1/episodes/:id`  
`GET /api/v1/channels/:id`  
`GET /api/v1/channel_prog`  

Includes `"watched_seconds"` when requesting channel programs with user_id.

--- 
<br />

`GET /api/v1/users/:id/favorite_channel_programs`

Sorted by watched time descending.

`GET /api/v1/users/:id/favorite_apps`   
`POST /api/v1/users/:id/favorite_apps`

Create/update favorite app with position.

Request body:
```json
{ "app_id": 1, "position": 2 }
```

--- 
<br />

`GET /api/v1/search?query=...`

Search across:
- movies
- tv shows
- seasons
- episodes
- channels
- channel programs
- apps

Supports title search and year search.

Example:
```bash
/api/v1/search?query=star
```

## 📖 API Reference (Swagger)

- OpenAPI spec lives at `public/swagger/openapi.yaml`.
- Interactive docs are served at `http://localhost:3000/docs` once the Rails server is running (served statically via Swagger UI).
- When deploying behind a different host, update the `servers` block in the YAML file to reflect the external URL if needed.


## 📝 Notes

- RSpec fixtures load the dataset deterministically to keep tests isolated and fast.
- Importer is fully idempotent — resets data on each call.
- Availability drives country-specific filtering via a polymorphic association. 
- Watch events enforce uniqueness per `(user_id, channel_program_id)` at DB + model level.