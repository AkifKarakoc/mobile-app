# TouDo Mobile — Smart Tourism Guide App

Flutter mobile client for **TouDo**, an AI-powered city exploration and gamified travel companion built around Izmir and Ephesus, Turkey.

> Developed as a Computer Engineering Graduation Project (*Bitirme Tezi*) at **Dokuz Eylül University**.
>
> Companion backend API: **[AkifKarakoc/toudo-backend](https://github.com/AkifKarakoc/toudo-backend)**

---

## Features

- **Nearby POI Discovery & Interactive Map:** Spatial discovery around your current location with category filters (`museum`, `restaurant`, `mosque`, `park`, `monument`, `beach`, `cafe`) and detail views.
- **Curated Walking Routes:** Browse multi-stop routes with waypoint lists, progress tracking, and route details.
- **Gamified Quests & Badges:** Location-based quest chains with optional photo verification steps, XP progression rings, and collectible achievement badges.
- **AI City Guide Chat:** Multi-session travel assistant with GPS-aware recommendations powered by the backend's built-in `demo` RAG mode, Ollama, or Google Gemini.
- **Camera Landmark Recognition:** Capture or pick monument photos to identify landmarks via Google Cloud Vision (or the backend's PostGIS fallback).
- **Favorites, Reviews & Travel Todos:** Bookmark places, write star-rated reviews, and manage personal trip checklists.
- **Authentication & Personalization:** JWT login/registration, optional Google Sign-In, optional Firebase push notifications, and **English / Turkish / German** localization (`assets/translations/`).

---

## Architecture

Feature-first **Clean Architecture** layered with Riverpod state management and code-generated immutable models:

```text
lib/
├── app/                # Env loader (.env / --dart-define), GoRouter navigation, Material theme
├── core/               # Dio + Retrofit network client (auth & refresh interceptors), FCM, storage, shared widgets
├── features/           # Feature modules (auth, badges, chat, favorites, home, image_identify,
│                       # nearby, notifications, onboarding, places, quests, reviews, routes, settings, todos, user)
├── features_shared/    # Cross-feature domain providers & models
└── l10n/               # Localization configuration (EN / TR / DE)
```

| Layer / Library | Choice |
| --- | --- |
| **Framework** | Flutter (Material 3) |
| **State Management** | `flutter_riverpod` |
| **Routing** | `go_router` |
| **Networking & Serialization** | `dio`, `retrofit`, `freezed`, `json_serializable` |
| **Maps & Location** | `google_maps_flutter`, `geolocator` |
| **Localization** | `easy_localization` (`en`, `tr`, `de`) |

---

## Quick Start

### 1. Start the Backend

Run **[toudo-backend](https://github.com/AkifKarakoc/toudo-backend)** locally via Docker Compose (`http://localhost:8080/api/v1`).

With `SEED_DEMO_DATA=true` (enabled by default in backend `dev`), you can sign in immediately with:

- **Email:** `demo@toudo.dev`
- **Password:** `Demo@1234`

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Configure Environment (Optional)

The app resolves local defaults automatically when `.env.dev` is absent, switching host by platform:

- **Android Emulator:** `http://10.0.2.2:8080/api/v1`
- **iOS Simulator / Desktop / Web:** `http://localhost:8080/api/v1`

To customize values, copy [`.env.example`](./.env.example) to `.env.dev` (or pass `--dart-define` flags directly):

```bash
cp .env.example .env.dev
```

Run against a custom host or physical device on your LAN:

```bash
flutter run --dart-define=API_BASE_URL=http://<YOUR_LAN_IP>:8080/api/v1
```

---

## Optional Firebase & Google Services

Google Maps, Google Sign-In, and Firebase Cloud Messaging are **optional** for local compilation and testing:

- `android/app/build.gradle.kts` applies the Google Services plugin only if `android/app/google-services.json` is present.
- `FCMManager` checks `Firebase.apps` before accessing `FirebaseMessaging`, so the app boots safely without Firebase configured.
- To enable full mobile maps, OAuth, and push notifications:
  1. Set `GOOGLE_MAPS_API_KEY` and `GOOGLE_CLIENT_ID` in `.env.dev` (or via `--dart-define`).
  2. Place your Firebase Android config at `android/app/google-services.json`.

---

## Code Quality & Tests

```bash
flutter analyze --no-fatal-infos
flutter test --no-pub
```
