# tagEat

Based on Flutter.

## Boilerplate Features
* Base PageView
* Home
* Restock
* Recipe
* Settings
* Item Details
* QR Code Scan
* Profile

### Folder Structure
```
.
├── lib
   └── routes
       ─ allDevices.dart
       ─ base.dart
       ─ blank.dart
       ─ device.dart
       ─ home.dart
       ─ itempage.dart
       ─ loginpage.dart
       ─ myProfile.dart
       ─ profile.dart
       ─ recipe.dart
       ─ restock.dart
       ─ scanner.dart
       ─ settings.dart
       ─ settingsPage.dart
   └── API.dart
   └── constants.dart
   └── DeviceData.dart
   └── main.dart
── README.md
```

## How to run

You need to follow these steps in order to run this application

- [1. Install Flutter](https://docs.flutter.dev/get-started/install)
- [2. Setup and Run Project](https://docs.flutter.dev/get-started/test-drive?tab=androidstudio)

For help getting started with Flutter, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### How to configure
To configure frontend app make the following changes:-
1. Add server URL in lib/routes/itemPage.dart in line 71.
2. Add server URL in lib/API.dart in line 5.
