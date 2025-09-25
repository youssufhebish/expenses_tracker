# Expenses Tracker Lite

A modern Flutter application for tracking personal expenses with currency conversion, receipt management, and comprehensive financial insights.

## 📱 Overview

Expenses Tracker Lite is a feature-rich expense tracking application built with Flutter, implementing Clean Architecture principles and modern state management patterns. The app provides users with an intuitive interface to manage their expenses, capture receipts, and track financial data with real-time currency conversion capabilities.

## 🏗️ Architecture & Structure

### Clean Architecture Implementation

The project follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── core/                    # Core functionality and shared resources
│   ├── configs/            # App configuration and environment setup
│   ├── database/           # Hive database configuration
│   ├── di/                 # Dependency injection setup
│   ├── error/              # Error handling and failure classes
│   ├── services/           # Core services (API, refresh service)
│   ├── themes/             # UI theming and styling
│   └── utils/              # Utility functions and helpers
├── features/               # Feature-based modules
│   ├── add_expense/        # Add expense feature
│   │   ├── data/          # Data layer (repositories, datasources, models)
│   │   ├── domain/        # Domain layer (entities, repositories, use cases)
│   │   └── presentation/  # Presentation layer (UI, BLoC, widgets)
│   ├── home/              # Home dashboard feature
│   └── home_layout/       # Main app layout and navigation
├── generated/             # Generated localization files
├── l10n/                  # Internationalization resources
└── widgets/               # Shared UI components
```

### Key Architectural Patterns

- **Clean Architecture**: Separation of data, domain, and presentation layers
- **Repository Pattern**: Abstraction of data sources
- **Use Case Pattern**: Encapsulation of business logic
- **Dependency Injection**: Using GetIt for service location
- **Feature-First Organization**: Modular structure by features

## 🔄 State Management Approach

### BLoC Pattern Implementation

The application uses **Flutter BLoC** for state management with the following structure:

#### Home Feature State Management
- **HomeBloc**: Manages expense listing, filtering, and financial summaries
- **States**: `HomeInitial`, `HomeLoading`, `HomeLoaded`, `HomeError`
- **Events**: `LoadExpensesEvent`, `RefreshExpensesEvent`, `LoadMoreExpensesEvent`, `ChangeFilterPeriodEvent`

#### Add Expense Feature State Management
- **AddExpenseBloc**: Handles expense creation, receipt saving, and currency conversion
- **States**: `AddExpenseInitial`, `ExpenseAdding`, `ExpenseAdded`, `ReceiptSaving`, `ReceiptSaved`, `CurrencyConversionLoaded`
- **Events**: `AddExpenseEvent`, `SaveReceiptEvent`, `LoadCurrencyRatesEvent`, `ResetFormEvent`

### State Management Benefits
- **Predictable State Changes**: Clear event-to-state mapping
- **Separation of Concerns**: Business logic separated from UI
- **Testability**: Easy to unit test BLoC logic
- **Reactive Programming**: Stream-based state updates

## 🌐 API Integration

### Currency Conversion Service

The app integrates with external currency conversion APIs to provide real-time exchange rates:

#### Implementation Details
- **Service**: `CurrencyConversionRemoteDataSource`
- **Repository**: `CurrencyConversionRepositoryImpl`
- **Use Case**: `GetCurrencyConversionRatesUseCase`
- **API Service**: `DioService` with custom interceptors

#### API Configuration
```dart
// Environment configuration
class EnvironmentConfig {
  static String get apiKey => dotenv.env['API_KEY'] ?? '';
  static String get baseUrl => dotenv.env['BASE_URL'] ?? 'https://api.example.com';
  static String get url => baseUrl + apiKey;
}
```

#### Error Handling
- **Network Failures**: Graceful handling of connection issues
- **Parsing Errors**: Robust JSON parsing with fallbacks
- **Rate Limiting**: Proper error messages for API limits

### HTTP Client Setup
- **Dio**: HTTP client with interceptors
- **Timeout Configuration**: 30-second timeouts for requests
- **Logging**: Debug logging for development
- **Error Interceptor**: Centralized error handling


### Storage Strategy
- **Local Storage**: Images stored in app documents directory
- **Unique Naming**: Timestamp-based file naming
- **Directory Organization**: Dedicated receipts folder
- **Path Management**: Absolute path storage for reliability

## 📹 Video Recording & Documentation

### App Demo Video
Check out our app demonstration video below:

<video width="100%" controls>
  <source src="expenses.mp4" type="video/mp4">
</video>

### Screen Recording Capabilities
The app supports screen recording for documentation and support purposes:

- **Receipt Capture Process**: Record the flow of capturing and saving receipts
- **Expense Addition**: Document the complete expense creation workflow
- **Currency Conversion**: Show real-time currency conversion in action
- **Navigation Flow**: Demonstrate app navigation and user experience

### Recording Implementation
- Uses device native screen recording capabilities
- Integrated with the image picker for seamless media capture
- Supports both photo and video documentation of expenses

## ⚖️ Trade-offs & Assumptions

### Technical Decisions

#### 1. Local-First Architecture
**Decision**: Use Hive for local data storage with optional API sync
**Trade-off**: 
- ✅ Offline functionality and fast access
- ❌ No real-time collaboration features
- **Assumption**: Users primarily need personal expense tracking

#### 2. BLoC for State Management
**Decision**: Flutter BLoC over alternatives like Riverpod or Provider
**Trade-off**:
- ✅ Predictable state management and excellent testing support
- ❌ More boilerplate code compared to simpler solutions
- **Assumption**: App complexity justifies structured state management

#### 3. Clean Architecture Implementation
**Decision**: Full Clean Architecture with multiple layers
**Trade-off**:
- ✅ Highly maintainable and testable code
- ❌ Initial development overhead and complexity
- **Assumption**: Long-term maintainability is prioritized

#### 4. Currency Conversion API
**Decision**: External API for real-time rates vs. static rates
**Trade-off**:
- ✅ Accurate, up-to-date conversion rates
- ❌ Dependency on external service and internet connectivity
- **Assumption**: Users need current exchange rates for accuracy

### Performance Considerations
- **Lazy Loading**: Expenses loaded with pagination
- **Image Optimization**: Local storage for quick access
- **State Caching**: BLoC state preservation during navigation
- **Memory Management**: Proper disposal of streams and controllers

## 🚀 How to Run the Project

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code
- iOS Simulator / Android Emulator

### Environment Setup

1. **Clone the repository**
```bash
git clone <repository-url>
cd expenses_tracker_lite
```

2. **Create environment file**
Create a `.env` file in the project root:
```env
# Currency conversion API configuration
API_KEY=your_api_key_here
BASE_URL=https://api.exchangerate-api.com/v4/latest/

# Optional: Additional configuration
DEBUG_MODE=true
```

3. **Install dependencies**
```bash
flutter pub get
```

4. **Generate code**
```bash
# Generate localization files
dart run intl_utils:generate

# Generate Hive adapters and other generated code
dart run build_runner build
```

5. **Run the application**
```bash
# Debug mode
flutter run

# Release mode
flutter run --release

# Specific platform
flutter run -d ios
flutter run -d android
```

### Environment Variables

The app uses the following environment variables in the `.env` file:

| Variable | Description | Required | Default |
|----------|-------------|----------|---------|
| `API_KEY` | Currency conversion API key | Yes | - |
| `BASE_URL` | API base URL | Yes | `https://api.example.com` |

### Build Configuration

#### Android
- Minimum SDK: 21
- Target SDK: 34
- Compile SDK: 34

#### iOS
- Minimum iOS Version: 12.0
- Deployment Target: 12.0

## 🐛 Known Bugs & Limitations

### Current Issues

#### 1. Test Suite Issues
**Status**: 🔴 Failing
**Description**: HomeBloc tests have mock configuration issues
**Impact**: Unit tests failing, but app functionality unaffected
**Workaround**: Manual testing for HomeBloc features
**Priority**: High - affects CI/CD pipeline

#### 2. Currency API Dependency
**Status**: 🟡 Limitation
**Description**: App requires internet for currency conversion
**Impact**: Limited functionality in offline mode
**Workaround**: Cached rates used when offline
**Priority**: Medium - consider local fallback rates

#### 3. Receipt Image Size
**Status**: 🟡 Limitation
**Description**: No automatic image compression
**Impact**: Large images may consume significant storage
**Workaround**: Manual image selection of smaller files
**Priority**: Low - implement image compression

### Unimplemented Features

#### 1. Data Export
**Description**: Export expenses to CSV/PDF formats
**Status**: Planned for future release
**Complexity**: Medium

#### 2. Expense Categories Management
**Description**: Custom category creation and management
**Status**: Currently uses predefined categories
**Complexity**: Low

#### 3. Budget Tracking
**Description**: Set and track monthly/weekly budgets
**Status**: Foundation exists, UI implementation needed
**Complexity**: Medium

#### 4. Multi-Currency Wallet
**Description**: Support for multiple currency accounts
**Status**: Backend partially implemented
**Complexity**: High

#### 5. Cloud Synchronization
**Description**: Sync data across multiple devices
**Status**: Architecture supports it, needs implementation
**Complexity**: High

### Performance Considerations

#### Memory Usage
- **Current**: Efficient for typical usage (< 1000 expenses)
- **Limitation**: Large datasets may impact performance
- **Recommendation**: Implement data archiving for old expenses

#### Battery Usage
- **Current**: Optimized for normal usage
- **Consideration**: Frequent API calls may impact battery
- **Mitigation**: Implement smart caching strategies

## 🧪 Testing

### Test Coverage
- **Unit Tests**: BLoC logic and use cases
- **Widget Tests**: UI components and interactions
- **Integration Tests**: End-to-end user flows

### Running Tests
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/features/add_expense/presentation/bloc/add_expense_bloc_test.dart

# Run with coverage
flutter test --coverage
```

## 📦 Dependencies

### Core Dependencies
- **flutter_bloc**: State management
- **get_it**: Dependency injection
- **hive**: Local database
- **dio**: HTTP client
- **dartz**: Functional programming utilities
- **image_picker**: Camera and gallery access
- **flutter_dotenv**: Environment configuration

### Development Dependencies
- **bloc_test**: BLoC testing utilities
- **mocktail**: Mocking framework
- **build_runner**: Code generation
- **flutter_lints**: Code analysis

## 🌍 Internationalization

The app supports multiple languages:
- **Arabic** (Primary): `ar`
- **English**: `en`

Localization files are located in `lib/l10n/` and generated files in `lib/generated/`.

## 🎨 UI/UX Design

### Design System
- **Material Design 3**: Modern Material Design implementation
- **Dark/Light Themes**: System-based theme switching
- **Responsive Layout**: Adapts to different screen sizes
- **Accessibility**: Screen reader support and proper contrast ratios

### Color Scheme
- **Primary**: Blue (#1D55F2)
- **Secondary**: Cyan (#25F4EE)
- **Background**: Dynamic based on theme
- **Surface**: Elevated surfaces with proper shadows

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📞 Support

For support and questions:
- Create an issue in the repository
- Check existing documentation
- Review the test files for usage examples

---

**Note**: This is a lite version of the expenses tracker. For enterprise features and advanced functionality, consider the full version of the application.
