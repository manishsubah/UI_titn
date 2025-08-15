# Titan UI - Flutter Responsive Design System

A modern, responsive, and picture-perfect Flutter UI design system for the Titan testing platform. This project showcases a comprehensive design system with beautiful animations, responsive layouts, and reusable components.

## 🎨 Features

### Design System
- **Modern Theme System**: Comprehensive color palette, typography, and spacing system
- **Responsive Design**: Adapts seamlessly across mobile, tablet, and desktop
- **Material 3 Design**: Latest Material Design principles
- **Custom Components**: Reusable UI components with consistent styling
- **Smooth Animations**: Beautiful micro-interactions and transitions

### Screens
- **Splash Screen**: Animated welcome screen with brand introduction
- **Login Screen**: Modern authentication interface with form validation
- **Home Dashboard**: Feature-rich dashboard with statistics and quick actions

### Responsive Breakpoints
- **Mobile**: < 600px
- **Tablet**: 600px - 900px  
- **Desktop**: > 1200px

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd titan_ui
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## 📱 Screenshots

### Splash Screen
- Animated logo and welcome text
- Smooth slide-up card animation
- Responsive layout for all screen sizes

### Login Screen
- Modern form design with validation
- Password visibility toggle
- Remember me functionality
- Configuration update option

### Home Dashboard
- Welcome section with gradient background
- Quick stats cards with icons
- Recent projects list with progress indicators
- Quick actions grid
- Bottom navigation

## 🎯 UI Components

### CustomButton
A versatile button component with multiple styles:

```dart
CustomButton(
  text: 'Get Started',
  type: ButtonType.primary,
  icon: Icons.arrow_forward,
  onPressed: () {},
  isFullWidth: true,
)
```

**Button Types:**
- `ButtonType.primary` - Primary action button
- `ButtonType.secondary` - Secondary action button  
- `ButtonType.outline` - Outlined button
- `ButtonType.text` - Text button

### CustomInputField
Advanced input field with validation and icons:

```dart
CustomInputField(
  label: 'Email Address',
  hint: 'Enter your email',
  prefixIcon: Icons.email_outlined,
  validator: InputValidators.email,
  keyboardType: TextInputType.emailAddress,
)
```

**Predefined Validators:**
- `InputValidators.email` - Email validation
- `InputValidators.required` - Required field validation
- `InputValidators.password` - Password validation
- `InputValidators.phone` - Phone number validation
- `InputValidators.url` - URL validation

### ResponsiveLayout
Responsive layout wrapper for different screen sizes:

```dart
ResponsiveLayout(
  mobile: MobileWidget(),
  tablet: TabletWidget(),
  desktop: DesktopWidget(),
)
```

### ResponsiveContainer
Container with responsive max-width and padding:

```dart
ResponsiveContainer(
  child: YourWidget(),
  maxWidth: 800,
  padding: EdgeInsets.all(16),
)
```

## 🎨 Theme System

### Colors
```dart
// Primary Colors
AppTheme.primaryColor      // #007BFF
AppTheme.primaryDark       // #0056B3
AppTheme.secondaryColor    // #6C757D

// Semantic Colors
AppTheme.successColor      // #28A745
AppTheme.warningColor      // #FFC107
AppTheme.errorColor        // #DC3545
AppTheme.infoColor         // #17A2B8

// Background Colors
AppTheme.backgroundColor   // #F8F9FA
AppTheme.surfaceColor      // #FFFFFF
AppTheme.cardColor         // #F5F6FA

// Text Colors
AppTheme.textPrimary       // #1B1B1B
AppTheme.textSecondary     // #6C757D
AppTheme.textMuted         // #ADB5BD
```

### Typography
```dart
AppTheme.heading1          // 32px, Bold, Poppins
AppTheme.heading2          // 28px, SemiBold, Poppins
AppTheme.heading3          // 24px, SemiBold, Poppins
AppTheme.heading4          // 20px, SemiBold, Poppins
AppTheme.bodyLarge         // 16px, Regular, Inter
AppTheme.bodyMedium        // 14px, Regular, Inter
AppTheme.bodySmall         // 12px, Regular, Inter
AppTheme.buttonText        // 16px, SemiBold, Inter
AppTheme.caption           // 12px, Regular, Inter
```

### Spacing
```dart
AppTheme.spacingXS         // 4px
AppTheme.spacingS          // 8px
AppTheme.spacingM          // 16px
AppTheme.spacingL          // 24px
AppTheme.spacingXL         // 32px
AppTheme.spacingXXL        // 48px
```

### Border Radius
```dart
AppTheme.radiusS           // 8px
AppTheme.radiusM           // 12px
AppTheme.radiusL           // 16px
AppTheme.radiusXL          // 24px
AppTheme.radiusXXL         // 32px
```

## 📐 Responsive Utilities

### Screen Detection
```dart
ResponsiveUtils.isMobile(context)
ResponsiveUtils.isTablet(context)
ResponsiveUtils.isDesktop(context)
ResponsiveUtils.isLandscape(context)
```

### Responsive Values
```dart
ResponsiveUtils.getScreenWidth(context)
ResponsiveUtils.getScreenHeight(context)
ResponsiveUtils.getResponsivePadding(context)
ResponsiveUtils.getResponsiveFontSize(context, baseSize)
ResponsiveUtils.getMaxContentWidth(context)
```

## 🎭 Animations

The app uses `flutter_animate` package for smooth animations:

- **Fade In**: Smooth opacity transitions
- **Slide Up**: Card animations from bottom
- **Scale**: Logo and button hover effects
- **Typewriter**: Text animations on splash screen

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  flutter_svg: ^2.2.0
  google_fonts: ^6.1.0
  lottie: ^3.1.0
  animated_text_kit: ^4.2.2
  flutter_animate: ^4.5.0
  shimmer: ^3.0.0
  cached_network_image: ^3.3.1
```

## 🏗️ Project Structure

```
lib/
├── constants/
│   └── app_theme.dart          # Theme configuration
├── utils/
│   └── responsive_utils.dart   # Responsive utilities
├── widgets/
│   ├── custom_button.dart      # Custom button component
│   └── custom_input_field.dart # Custom input component
├── ui/
│   ├── splash_screen.dart      # Welcome screen
│   ├── login_screen.dart       # Authentication screen
│   └── home_screen.dart        # Dashboard screen
└── main.dart                   # App entry point
```

## 🎯 Best Practices

### Responsive Design
- Always use `ResponsiveUtils` for screen detection
- Implement different layouts for mobile, tablet, and desktop
- Use `ResponsiveContainer` for consistent content width
- Test on multiple screen sizes

### Component Usage
- Use predefined theme colors and spacing
- Implement form validation with `InputValidators`
- Use `CustomButton` for consistent button styling
- Apply animations sparingly for better UX

### Performance
- Use `const` constructors where possible
- Implement proper disposal of controllers
- Optimize images and assets
- Use `shrinkWrap: true` for nested lists

## 🔧 Customization

### Adding New Colors
```dart
// In app_theme.dart
static const Color customColor = Color(0xFF123456);
```

### Creating New Components
```dart
class CustomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // Use theme constants
      padding: EdgeInsets.all(AppTheme.spacingM),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
      ),
    );
  }
}
```

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📞 Support

For support and questions, please open an issue in the repository.

---

**Built with ❤️ using Flutter**
