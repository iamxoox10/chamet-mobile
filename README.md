# Chamet MVP (Flutter, Mobile Only)

This minimal app is ready for **Codemagic** to build a **debug APK**. It opens a **real-time video room** using **Jitsi** in an in-app browser. No server required.

## Build on Codemagic
1. Push this project to a **public GitHub repo**.
2. In Codemagic, choose **Flutter App** workflow.
3. Set project path to the repo root (where `pubspec.yaml` is).
4. Target: **Android → Debug APK**.
5. Start build → download the APK to your phone.

## Later: Switch to Agora
Replace `_startCall` with your Agora Web room URL or integrate native Agora Flutter SDK.

