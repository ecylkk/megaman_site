# 🎮 Rockman Portfolio (Mega Man 3 Edition)

[![Ruby Version](https://img.shields.io/badge/Ruby-3.4.2-red?logo=ruby&logoColor=white)](https://www.ruby-lang.org/)
[![Rails Version](https://img.shields.io/badge/Rails-7.1.3-brightred?logo=rails&logoColor=white)](https://rubyonrails.org/)
[![Docker](https://img.shields.io/badge/Docker-Enabled-blue?logo=docker&logoColor=white)](https://www.docker.com/)
[![Style](https://img.shields.io/badge/Style-Retro_8--bit-ff69b4?logo=nintendoapp&logoColor=white)](https://en.wikipedia.org/wiki/Mega_Man_3)

## 🚀 Rockman 3 Stage Select Experience
A high-performance, retro-styled personal portfolio built with **Ruby on Rails**, featuring a fully interactive Mega Man 3 (Rockman 3) stage selection interface.

---

## ✨ Today's Massive Overhaul (Update Log)

We've completely transformed the site from a standard Rails app into a pixel-perfect 8-bit experience:

- **Rockman 3 UI Engine**: 
  - Implemented a 3x3 responsive grid with a centered Player Avatar (`KAI`).
  - Pixel-perfect styling with "Press Start 2P" typography and scanline-ready contrast.
  - Scroll-free "Single Viewport" design optimized for all screen heights.
- **Interactive Navigation**:
  - **Keyboard Support**: Full `WASD` and `Arrow Key` navigation with `Enter` to select.
  - **Mouse Interaction**: High-contrast hover scaling and flash effects.
  - **Smooth Transitions**: Integrated "Flash-to-Stage" effects before navigation.
- **Audio System**:
  - Integrated Mega Man 3 Select BGM with a fixed-dimension toggle to prevent UI layout shifts.
  - Smart Autoplay handling for modern browsers.
- **Critical Fixes**:
  - **Bfcache Repair**: Fixed the "Blurry Font" bug when using the browser's Back button by handling `pageshow` style persistence.
  - **Layout Locking**: Forced containers to 100vh with flex-centering to prevent any vertical or horizontal scrolling.
- **DevOps**:
  - Full **Docker** containerization to ensure cross-platform consistency (bypass Windows Ruby native gem issues).

---

## 🛠 Technical Stack

| Component | Technology | Role |
|-----------|-----------|---------|
| **Backend** | Ruby on Rails 7.1.3 | Core Logic & Routing |
| **Language** | Ruby 3.4.2 | High-level backend logic |
| **Frontend** | Vanilla JS / CSS | Custom Retro UI & Interaction |
| **Environment** | Docker / Compose | Consistent Dev/Prod Environment |
| **Database** | SQLite3 | Lightweight Data Persistence |
| **Animation** | CSS3 Keyframes | 8-bit scaling and pulsing |

---

## 🏗 Setup & Launch (Recommended: Docker)

To ensure all native extensions (`nokogiri`, `sqlite3`) work perfectly regardless of your OS:

```bash
# Clone and navigate
cd megaman_site

# Launch with Docker Compose
docker compose up --build -d

# Visit: http://localhost:3000
```

---

## 📐 Interaction Shortcuts

- **W / Up**: Move Up
- **A / Left**: Move Left
- **S / Down**: Move Down
- **D / Right**: Move Right
- **Enter**: Access Stage
- **Space/Click**: Toggle BGM

---

*Crafted by KAI & Antigravity with obsession for detail and retro gaming passion.*
