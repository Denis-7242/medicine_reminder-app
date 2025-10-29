# 💊 Medicine Reminder & Tracker

A beautiful and functional Flutter app to help users remember to take their medications on time and track their adherence.

## ✨ Features

- **Add Medicine**: Create medicine reminders with name, dosage, frequency, and multiple daily times
- **Smart Notifications**: Receive local notifications at scheduled times
- **Track Adherence**: Mark medicines as taken or missed with simple checkboxes
- **History View**: Review past medication logs with color-coded adherence percentages
- **Beautiful UI**: Calm teal/pastel colors with smooth animations
- **Dark Mode Support**: Elegant dark theme included
- **Local Storage**: All data stored securely on device using Hive

## 📱 Screenshots

The app includes three main screens:
- **Today**: View today's medication schedule with progress tracking
- **Add**: Create new medicine reminders
- **History**: Review past medication logs grouped by date

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Android Studio / Xcode for emulator/simulator
- A physical device or emulator for testing

### Installation

1. Clone or download this project

2. Install dependencies:
```bash
flutter pub get
```

3. Generate Hive adapters (if not already generated):
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

4. Run the app:
```bash
flutter run
```

## 📦 Project Structure

```
lib/
 ┣ models/
 ┃ ┣ medicine_model.dart        # Data models
 ┃ ┗ medicine_model.g.dart      # Generated Hive adapters
 ┣ providers/
 ┃ ┗ medicine_provider.dart     # State management with Provider
 ┣ services/
 ┃ ┣ notification_service.dart  # Local notifications
 ┃ ┗ hive_service.dart          # Local database operations
 ┣ screens/
 ┃ ┣ home_screen.dart           # Today's schedule
 ┃ ┣ add_medicine_screen.dart   # Add/edit medicines
 ┃ ┗ history_screen.dart        # Medication history
 ┣ widgets/
 ┃ ┣ medicine_tile.dart         # Custom medicine card widget
 ┃ ┗ custom_button.dart         # Reusable button widget
 ┗ main.dart                    # App entry point
```

## 🔧 Configuration

### Android

For Android 13+ (API level 33), notification permissions are automatically requested. The app includes all necessary permissions in `AndroidManifest.xml`:

- `POST_NOTIFICATIONS` - Show notifications
- `SCHEDULE_EXACT_ALARM` - Schedule precise reminders
- `RECEIVE_BOOT_COMPLETED` - Restore reminders after device restart

### iOS

Add the following to your `Info.plist` for notification support:

```xml
<key>UIBackgroundModes</key>
<array>
    <string>fetch</string>
    <string>remote-notification</string>
</array>
```

## 📚 Dependencies

- **provider** (^6.1.1) - State management
- **hive** (^2.2.3) - Local NoSQL database
- **hive_flutter** (^1.1.0) - Hive Flutter integration
- **flutter_local_notifications** (^17.1.2) - Local notifications
- **intl** (^0.19.0) - Date/time formatting

## 🎨 Design Features

- Soft teal/pastel color scheme for a calming effect
- Rounded cards and buttons for modern UI
- Responsive layout for phones and tablets
- Smooth transitions and animations
- Color-coded status indicators (Green = Taken, Red = Missed, Orange = Pending)
- Progress tracking with percentage indicators

## 🔔 Notifications

The app uses `flutter_local_notifications` to schedule reminders:
- Notifications are scheduled for exact times
- Persistent across app restarts
- Show medicine name and dosage
- Support for multiple daily reminders per medicine

## 💾 Data Storage

All data is stored locally using Hive:
- **Medicines**: Stores medicine details and reminder times
- **Logs**: Tracks daily medication intake with timestamps
- No internet connection required
- Fast and efficient local database

## 🚨 Known Limitations

- Currently supports "Daily" frequency (Weekly and As Needed are stored but not fully implemented)
- No cloud backup (all data is local)
- No medicine inventory tracking
- No refill reminders

## 🔮 Future Enhancements

- [ ] Cloud sync with Firebase
- [ ] Medicine inventory management
- [ ] Refill reminders
- [ ] Statistics and insights
- [ ] Export logs to CSV/PDF
- [ ] Multi-user support for caregivers
- [ ] Medication interaction warnings
- [ ] Camera to scan medicine labels

## 📄 License

This is an MVP project created for demonstration purposes.

## 🤝 Contributing

This is an MVP project. Feel free to fork and enhance with additional features!

## 📞 Support

For issues or questions, please open an issue in the repository.

---

Made with ❤️ by Denis using Flutter