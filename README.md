# 🎬 iOS Movies App

A comprehensive iOS application for browsing, searching, and discovering movies with detailed information, cast details, reviews, and intelligent search functionality.

![iOS](https://img.shields.io/badge/iOS-18.2+-blue.svg)
![Swift](https://img.shields.io/badge/Swift-5.0+-orange.svg)
![Xcode](https://img.shields.io/badge/Xcode-16.0+-blue.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)

## 📋 Table of Contents

- [Features](#-features)
- [Architecture](#-architecture)
- [Installation](#-installation)
- [Configuration](#-configuration)
- [Project Structure](#-project-structure)
- [Key Components](#-key-components)
- [Smart Search Algorithm](#-smart-search-algorithm)
- [API Integration](#-api-integration)
- [Recent Improvements](#-recent-improvements)
- [Contributing](#-contributing)

## ✨ Features

### Core Functionality
- **📱 Movie Discovery**: Browse a comprehensive list of movies with poster images
- **🔍 Intelligent Search**: Advanced search functionality with smart token-based matching
- **📝 Movie Details**: Detailed movie information including synopsis, ratings, and genres
- **🎭 Cast Information**: View cast members with their photos and character details
- **⭐ User Reviews**: Read and browse user reviews with ratings
- **🎯 Similar Movies**: Discover related movies based on your current selection
- **📍 Location Integration**: Location-based features with user permission
- **🕒 Recent Searches**: Quick access to recently searched movies with NSCache optimization

### UI/UX Features
- **📱 Native iOS Design**: Clean, intuitive interface following iOS design principles
- **🌟 Custom Table View Cells**: Specialized cells for different content types
- **🎨 Image Caching**: Optimized image loading and caching for smooth scrolling
- **🔄 Pull-to-Refresh**: Easy content refresh functionality
- **📐 Dynamic Cell Heights**: Adaptive layouts for different content sizes
- **🎯 Collection Views**: Horizontal scrolling for cast, reviews, and similar movies

## 🏗 Architecture

The app follows the **MVVM (Model-View-ViewModel)** architecture pattern with a modular approach:

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│     Views       │◄──►│   ViewModels    │◄──►│     Models      │
│                 │    │                 │    │                 │
│ • ViewControllers│    │ • Data Logic    │    │ • Data Structures│
│ • Custom Cells   │    │ • Business Logic│    │ • API Models    │
│ • Storyboards   │    │ • Validation    │    │ • Core Data     │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         └───────────────────────┼───────────────────────┘
                                 │
                    ┌─────────────────┐
                    │    Services     │
                    │                 │
                    │ • WebService    │
                    │ • LocationService│
                    │ • ImageCache    │
                    └─────────────────┘
```

### Key Architectural Principles
- **🔄 Delegation Pattern**: For communication between components
- **🎯 Protocol-Oriented**: Extensive use of protocols for flexibility
- **📦 Modular Design**: Clear separation of concerns
- **⚡ Async Operations**: Proper handling of network calls and UI updates
- **🧠 Memory Management**: Efficient caching and resource management


## 🚀 Installation

### Prerequisites
- **Xcode 16.0+**
- **iOS 18.2+**
- **Swift 5.0+**
- **Valid TMDB API Key**

### Setup Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/iOSMoviesApp.git
   cd iOSMoviesApp
   ```

2. **Open in Xcode**
   ```bash
   open iOSMoviesApp.xcodeproj
   ```

3. **Configure API Token**
   - Update the `BEARER_TOKEN` in `iOSMoviesApp/constants/env.swift`
   - Get your API key from [The Movie Database (TMDB)](https://www.themoviedb.org/documentation/api)

4. **Build and Run**
   - Select your target device/simulator
   - Press `Cmd + R` to build and run

## ⚙️ Configuration

### API Configuration
```swift
// iOSMoviesApp/constants/env.swift
var BEARER_TOKEN = "Bearer YOUR_TMDB_API_TOKEN_HERE"
```

### Location Permissions
The app requests location permissions for enhanced features. Update `Info.plist` as needed:
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app uses location to provide personalized movie recommendations</string>
```

## 📁 Project Structure

```
iOSMoviesApp/
├── 📱 App/
│   ├── AppDelegate.swift
│   ├── SceneDelegate.swift
│   └── Info.plist
├── 🎯 Controllers/
│   ├── DiscoveryPage/
│   │   └── DiscoveryPageViewController.swift
│   ├── DetailsPage/
│   │   └── DetailsScreenViewController.swift
│   └── SearchScreenViewController/
│       └── SearchScreenViewController.swift
├── 📊 Models/
│   ├── Movie.swift
│   ├── Cast.swift
│   ├── Reviews.swift
│   ├── Info.swift
│   └── Similar.swift
├── 🧠 ViewModels/
│   ├── MovieListViewModel.swift
│   ├── DetailsScreenViewModel.swift
│   ├── MovieViewModel.swift
│   └── SearchScreenViewModel.swift
├── 🎨 CustomTableViewCells/
│   ├── DiscoveryMovieCardTableViewCell/
│   ├── CastDetailsTableViewCell/
│   ├── ReviewTableViewCell/
│   ├── InfoTableViewCell/
│   └── SimilarTableViewCell/
├── 🌐 Services/
│   ├── WebService.swift
│   └── LocationService.swift
├── 🛠 Utils/
│   ├── SmartSearchAlgo.swift
│   ├── RecentSearchedCache.swift
│   ├── ImageCache.swift
│   └── Extensions/
├── 📐 Constants/
│   ├── env.swift
│   └── PresetSizeValue.swift
└── 🎨 Resources/
    ├── Assets.xcassets
    ├── Main.storyboard
    └── LaunchScreen.storyboard
```

## 🔧 Key Components

### 1. Discovery Page
- **Purpose**: Main movie browsing interface
- **Features**: Movie grid, search bar, location display
- **Key Files**: `DiscoveryPageViewController.swift`, `MovieListViewModel.swift`

### 2. Movie Details
- **Purpose**: Comprehensive movie information display
- **Features**: Movie info, cast, reviews, similar movies
- **Key Files**: `DetailsScreenViewController.swift`, `DetailsScreenViewModel.swift`

### 3. Search Functionality
- **Purpose**: Advanced movie search with intelligent matching
- **Features**: Real-time search, recent searches, smart algorithms
- **Key Files**: `SearchScreenViewController.swift`, `SmartSearchAlgo.swift`

### 4. Custom Cells
- **Purpose**: Specialized UI components for different content types
- **Features**: Dynamic heights, collection views, image loading
- **Key Files**: Various cell classes in `CustomTableViewCells/`

## 🧠 Smart Search Algorithm

The app implements a sophisticated search algorithm based on specific requirements:

### Algorithm Features
- **🎯 Token-based Matching**: Searches match word prefixes only
- **📝 Order Independence**: "back turn" matches "turn back"
- **🔤 Case Insensitive**: Handles various text cases
- **⚡ Performance Optimized**: Efficient string matching
- **🎨 Diacritic Support**: Handles accented characters

### Search Requirements Implementation

```swift
struct SmartSearchAlgo {
    // 1. Empty string returns all movies
    // 2. Prefix matching only (not substring)
    // 3. All tokens must match separate words
    // 4. Order independence
    // 5. Longer tokens matched first
    // 6. Whitespace normalization
}
```

### Example Matches
- **"Av"** → ✅ "Avengers", "Avatar" | ❌ "Kraven"
- **"M M"** → ✅ "Mad Max" | ❌ "Mission"
- **"back turn"** → ✅ "Turn Back", "Don't Turn Back"

## 🌐 API Integration

### The Movie Database (TMDB) API
- **Base URL**: `https://api.themoviedb.org/3/`
- **Authentication**: Bearer Token
- **Endpoints Used**:
  - `/movie/popular` - Popular movies
  - `/movie/{id}` - Movie details
  - `/movie/{id}/credits` - Cast information
  - `/movie/{id}/reviews` - User reviews
  - `/movie/{id}/similar` - Similar movies

### Network Layer
```swift
class WebService {
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void)
}
```

## 🆕 Recent Improvements

### Search Enhancements
- ✅ **Fixed Multiple Recent Movies Display**: Resolved row count logic
- ✅ **NSCache Optimization**: Improved performance with memory-based caching
- ✅ **Auto-Refresh Logic**: Smart refresh on text changes and navigation
- ✅ **Type-Safe Implementation**: Clean, linter-error-free code

### UI/UX Improvements  
- ✅ **Collection View Fixes**: Resolved width and visibility issues
- ✅ **Review Display**: Fixed collection view layout for movie reviews
- ✅ **Navigation Flow**: Enhanced similar movie selection and navigation
- ✅ **Memory Management**: Optimized caching strategies

### Performance Optimizations
- ⚡ **Image Caching**: Custom image cache for smooth scrolling
- 🧠 **Memory Efficiency**: NSCache for temporary data storage
- 🔄 **Async Operations**: Proper threading for network operations
- 📱 **UI Responsiveness**: Optimized table view and collection view performance

## 🔮 Future Enhancements

### Planned Features
- 🌙 **Dark Mode Support**: Complete dark theme implementation
- 📱 **iPad Support**: Universal app with iPad-optimized layouts
- 💾 **Offline Mode**: Core Data integration for offline viewing
- 🔐 **User Accounts**: Personalized experience with favorites
- 🎬 **Video Trailers**: Integrated trailer playback
- 🌍 **Internationalization**: Multi-language support

### Technical Improvements
- 🧪 **Unit Testing**: Comprehensive test coverage
- 📊 **Analytics**: Usage tracking and performance monitoring
- 🔄 **CI/CD**: Automated building and deployment
- 📈 **Performance Monitoring**: Real-time performance tracking

## 🤝 Contributing

We welcome contributions! Please follow these steps:

1. **Fork the repository**
2. **Create a feature branch**: `git checkout -b feature/amazing-feature`
3. **Commit changes**: `git commit -m 'Add amazing feature'`
4. **Push to branch**: `git push origin feature/amazing-feature`
5. **Open a Pull Request**

### Development Guidelines
- Follow Swift coding conventions
- Write meaningful commit messages
- Add unit tests for new features
- Update documentation as needed



**⭐ Star this repo if you find it helpful!**

Made with ❤️ by the iOS Movies App Team
