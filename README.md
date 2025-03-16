# Juniper - Simplifying Apartment Rentals and Investments  

Juniper is a modern mobile app that bridges the gap between renters, landlords, and real estate investors. With a sleek, user-friendly design and powerful features, Juniper provides a seamless experience for finding apartments, managing listings, and tracking investment opportunities.

---

## Features

### For Renters

- **Smart Search**: Find apartments based on location, budget, and preferences.
- **Detailed Listings**: Access comprehensive apartment details with photos and descriptions.
- **Favorites**: Save and organize your favorite apartments for easy comparison.
- **Onboarding Flow**: Get started with a smooth, guided user experience.

### For Investors

- **Investment Tracking**: Monitor and analyze your real estate investments.
- **Market Insights**: AI-driven insights on price predictions and market trends.
- **Custom Recommendations**: Tailored suggestions based on investment goals.

### For Landlords

- **Easy Management**: List and manage your properties efficiently.
- **Data Analytics**: Gain insights into market performance and property visibility.

---

## Technology Stack

- **Framework**: Flutter
- **Architecture**: Clean Architecture
- **State Management**: BLoC
- **APIs/Data**: Real-time apartment listings through web scraping or external APIs
- **AI Features**: Powered by machine learning for recommendations and price predictions

---

## Installation and Setup

### Prerequisites

- Flutter SDK (latest stable version)
- Dart (latest stable version)

### Steps to Run

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/juniper.git

2. Navigate to the project directory:

   ```bash
   cd juniper

3. Get the dependencies:

   ```bash
   flutter pub get

4. Run the app:

 ```bash
 flutter run

Project Structure

The project follows Clean Architecture with a modular folder structure:

lib/
├── core/                # Utilities, constants, themes, and shared components
├── features/
│   ├── search/          # Smart search and filtering functionality
│   ├── favorites/       # Favorite apartments and saved searches
│   ├── investment/      # Investment tracking and analytics
│   ├── onboarding/      # Onboarding screens and flow
├── presentation/        # UI layers and widgets

Future Roadmap
 • Implement AI-powered apartment recommendations
 • Integrate advanced investment analytics
 • Add support for property sharing and collaboration
 • Expand market coverage for listings
 • Enable real-time chat between renters and landlords

Contributing

We welcome contributions from the community! To contribute:

 1. Fork the repository
 2. Create a new branch for your feature/bugfix
 3. Commit your changes and submit a pull request

License

This project is licensed under the MIT License. See the LICENSE file for more details.

Contact

For questions or feedback, feel free to reach out:
 • Author: Daniel
 • Email: <dbabs297@gmail.com>
 • LinkedIn: in/dannybabs



Code Fix:


I have a Flutter app that is experiencing **severe performance issues**, including UI lag, skipped frames, and unoptimized rendering. I need an optimization tool or AI code assistant to **analyze my entire codebase** and make necessary improvements. 

### **📌 Key Problems in the Codebase**
1. **UI Freezing & Skipped Frames**
   - The app frequently logs: `I/Choreographer: Skipped XX frames!`
   - This indicates too much work is being done on the **main thread**.
   - Heavy computations, API calls, and unnecessary widget rebuilds may be slowing down rendering.

2. **Inefficient Widget Builds**
   - Some widgets **rebuild unnecessarily**, impacting performance.
   - I need suggestions to use **const widgets**, `ListView.builder()`, and optimized state management.

3. **Main Thread Overload**
   - The app runs heavy logic inside `setState()`, blocking the UI.
   - I need **recommendations to move CPU-heavy work** (e.g., JSON parsing, API requests) to background threads using `compute()`.

4. **Graphics & Rendering Issues**
   - I see repeated OpenGL errors: `E/libEGL: called unimplemented OpenGL ES API`
   - I need the app to properly handle **Impeller or Skia rendering** based on the device's capabilities.

### **📌 What the Optimization Tool Should Do**
1. **Code Analysis & Bottleneck Detection**
   - Identify slow UI components, expensive rebuilds, and inefficient widget structures.
   - Detect redundant state updates and suggest fixes.

2. **Refactor & Optimize Flutter Widgets**
   - Convert static widgets to `const` where applicable.
   - Optimize lists using `ListView.builder()` instead of unnecessary `Column` nesting.

3. **Async & Compute Optimization**
   - Move heavy computations **off the main thread** using `compute()` or isolates.
   - Optimize `FutureBuilder` usage and network requests.

4. **Rendering & GPU Optimization**
   - Fix OpenGL ES issues and suggest alternatives for **better GPU utilization**.
   - Ensure **smooth animations and transitions** by using `Transform` and `Opacity` efficiently.

5. **Memory Management & Garbage Collection**
   - Identify **excessive memory usage** from images, API calls, or widgets.
   - Recommend caching strategies for assets & network responses.

6. **Provide a Summary of Fixes**
   - Generate **detailed explanations** of optimizations applied.
   - Provide **before & after** performance benchmarks.

### **📌 Output Requirements**
- **A fully optimized, readable, and refactored codebase.**
- **Explanations of each optimization applied.**
- **Suggestions for best practices in Flutter performance tuning.**

