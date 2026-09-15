# 🔧 Servant — HVAC & Plumbing Service App

A full-featured, production-ready **Flutter mobile application** that connects customers with HVAC and plumbing service providers. The platform supports two distinct user roles — **Customer** and **Service Provider** — each with their own dedicated workflow, dashboards, and features.

---

## 📱 Overview

**Servant** is a two-sided marketplace mobile app built for the service industry. Customers can browse, book, and pay for HVAC/plumbing services, while service providers can manage incoming requests, track earnings, and update their availability — all from a single cross-platform app.

---

## ✨ Key Features

### 👤 Customer (User) Side
- **Onboarding & Authentication** — Smooth onboarding flow, email/password sign-up & login, forgot password with OTP verification, and password reset
- **Role Selection** — Users choose their role (Customer / Service Provider) during registration
- **Service Browsing & Booking** — Browse available HVAC & plumbing services with details, images, pricing, and location
- **Real-Time Service Requests** — Submit service requests with live location tracking via Google Maps & Geolocator
- **Stripe Payment Integration** — Secure card payment via Stripe Payment Sheet SDK; Setup Intent flow with payment method saving
- **Order Tracking** — View active, pending, and completed service orders
- **Service Rating** — Rate completed services to maintain quality standards
- **Profile Management** — Edit profile, change password, view privacy policy
- **Push Notifications** — Real-time service update notifications (SSE-based)

### 🛠️ Service Provider Side
- **Provider Dashboard** — Overview of incoming service requests and job status
- **Job Management** — Accept/reject service requests, update job status
- **Earnings Overview** — Visual revenue analytics with weekly line charts (fl_chart)
- **Profile Management** — Manage provider profile and service availability

### 🏗️ Architecture & Engineering
- **GetX State Management** — Reactive state, dependency injection, and navigation via GetX
- **Feature-First Architecture** — Clean separation of concerns: features/, core/, routes/
- **Secure Credential Handling** — API keys loaded from .env (flutter_dotenv); never committed to version control
- **Persistent Auth** — JWT token, user ID, and role persisted via SharedPreferences
- **Network Layer** — Centralized NetworkCaller service with Dio for API communication
- **Shimmer Loading** — Skeleton loading states for polished UX
- **Responsive Layout** — Device-adaptive sizing using the Sizer package

---

## 🗂️ Project Structure

```
lib/
├── main.dart                    # App entry point, dotenv & auth initialization
├── app.dart                     # MyApp, theme & routing setup
├── routes/
│   └── app_routes.dart          # Centralized GetX route definitions
├── core/
│   ├── bindings/                # GetX controller binders
│   ├── common/widgets/          # Reusable UI widgets
│   ├── models/                  # Shared data models
│   ├── services/
│   │   ├── auth_service.dart    # JWT token management & SharedPreferences
│   │   └── network_caller.dart  # Centralized HTTP/Dio network service
│   └── utils/
│       ├── constants/           # Colors, sizes, image paths, URLs
│       ├── logging/             # Debug/release logger
│       └── theme/               # Light & dark theme definitions
└── features/
    ├── splash_screen/
    ├── on_boarding/
    ├── authentication/          # Login, Sign-Up, OTP, Forgot/Reset Password
    ├── notification/
    ├── user/
    │   ├── home/                # Service browsing, request submission
    │   ├── service/
    │   │   ├── controller/      # ServicesController, ServicePaymentController
    │   │   ├── data/            # Repository & data sources
    │   │   └── presentation/    # PaymentScreen, RatingScreen, ServiceScreen
    │   ├── profile/             # Edit profile, change password, privacy policy
    │   └── nav_bar/             # Bottom navigation bar (user)
    └── provider/
        ├── home/                # Provider dashboard, job details
        ├── service/             # Provider job management
        ├── earning/             # EarningsController, EarningsOverviewScreen
        └── provider_nav_bar/    # Bottom navigation bar (provider)
```

---

## 🧰 Tech Stack

| Category               | Package / Technology                          |
|------------------------|-----------------------------------------------|
| Framework              | Flutter (Dart)                                |
| State Management       | GetX ^4.6.6                                   |
| HTTP / Networking      | Dio ^5.7.0, http ^1.1.0                       |
| Payments               | flutter_stripe ^11.5.0                        |
| Maps & Location        | google_maps_flutter, geolocator, geocoding    |
| Charts                 | fl_chart ^1.0.0                               |
| UI / Fonts             | google_fonts ^6.2.1                           |
| Loading States         | shimmer ^3.0.0, flutter_spinkit               |
| OTP Input              | pin_code_fields ^8.0.1                        |
| Image Handling         | image_picker ^1.1.2                           |
| Persistent Storage     | shared_preferences ^2.3.2                     |
| Env / Secrets          | flutter_dotenv ^5.2.1                         |
| Loading Overlay        | flutter_easyloading ^3.0.5                    |
| Real-Time Updates      | flutter_client_sse ^2.0.3                     |
| Date Formatting        | intl ^0.18.1                                  |
| Deep Linking           | url_launcher ^6.1.12                          |

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK ^3.7.2
- Dart SDK
- Android Studio / Xcode
- A Stripe account (for payment features)
- Google Maps API key

### Setup

1. **Clone the repository**
   ```bash
   git clone <repo-url>
   cd servant-hvac_and_plumbing_service
   ```

2. **Create environment file**
   Create a `.env` file in the root and fill in your keys:
   ```
   BASE_URL=https://your-api-url.com
   STRIPE_PUBLISHABLE_KEY=pk_test_...
   GOOGLE_MAPS_API_KEY=AIza...
   ```

3. **Add Firebase config files** *(if using Firebase)*
   - Android: `android/app/google-services.json`
   - iOS: `ios/Runner/GoogleService-Info.plist`

4. **Install dependencies**
   ```bash
   flutter pub get
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

---

## 🔐 Security Notes

The following files are **git-ignored** and must never be committed:
- `.env` — environment variables and API keys
- `lib/core/services/stripe_keys.dart` — Stripe secret key
- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`

---

## 📸 Screenshots

> *(Add screenshots here once the app is deployed)*

---

## 📄 License

This project is private and not licensed for public distribution.
