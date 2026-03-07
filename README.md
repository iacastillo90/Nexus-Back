<p align="center">
  <img src="app_mobile/assets/images/app_icon.png" width="120" alt="Nexus Logo">
</p>
<h1 align="center">Nexus: Consciencia Digital</h1>

<p align="center">
  <a href="#features"><strong>Features</strong></a> ·
  <a href="#architecture"><strong>Architecture</strong></a> ·
  <a href="#getting-started"><strong>Getting Started</strong></a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x-blue.svg?logo=flutter" alt="Flutter">
  <img src="https://img.shields.io/badge/Node.js-18.x-green.svg?logo=node.js" alt="Node.js">
  <img src="https://img.shields.io/badge/Database-MySQL-orange.svg?logo=mysql" alt="MySQL">
</p>

Nexus is a cyberpunk-themed, AI-driven social network. It introduces innovative features like "Reality Layers" (AR-based location interactions), Voice Cloning, and dynamic "Karma" scoring to encourage authenticity.

---

## 🚀 Features
- **Echo (Digital Twin)**: Train an AI clone of yourself to interact with others on your behalf using Vector Search and Generative AI.
- **Reality Layers**: Drop and discover posts in specific geographical locations with AR features.
- **Karma System**: Gamified metrics (Authenticity, Community, Contribution) for verifying users.
- **Offline-First Resilience**: Posts and likes sync via Isar local DB when connectivity drops, using Optimistic UI.
- **Full Monetization Ready**: Integrated with RevenueCat, Stripe, Google Wallet, and Apple Pay.

## 🏗 Architecture
Nexus uses a Monorepo strategy:
- **/app_mobile**: Flutter Mobile Client (Riverpod, Dio, Isar)
- **/back**: Node.js/Express Backend (Sequelize, MySQL, Socket.io)

```text
📦 Nexus Monorepo
 ┣ 📂 app_mobile       # Flutter application (Frontend)
 ┣ 📂 back            # Express server (Backend)
 ┣ 📂 Docs            # Architecture and historic specs
 ┣ 📜 .env            # Master Environment Variables
 ┗ 📜 sync_env.sh     # Utility to synchronize .env
```

## 🛠 Getting Started

### 1. Environment Setup
Fill out the master `.env` at the root of the project (reference `.env.example`).
Then, synchronize the `.env` to both sub-projects:
```bash
./sync_env.sh
```

### 2. Backend Setup
```bash
cd back
npm install
npm run db:create
npm run db:migrate
npm run dev
```

### 3. Mobile App Setup
```bash
cd app_mobile
flutter pub get
# Generate Riverpod/Freezed files
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```

## 🔐 Security 
- Powered by `freerasp` (Anti-Tampering/Root/Jailbreak detection on mobile).
- Strict environment validation via `envalid` on Node.js.
- Rate limiting, Helmet headers, and JWT interceptors on network calls.
