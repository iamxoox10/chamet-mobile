import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Chamet',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final String roomUrl = "https://meet.jit.si/testchametroom";

  /// Open video call in external browser
  void _startCall(BuildContext context) async {
    final uri = Uri.parse(roomUrl);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not open video call")),
      );
    }
  }

  /// Copy room link to clipboard
  void _copyLink(BuildContext context) {
    // This avoids extra dependencies — simple snackbar with the link
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Room link: $roomUrl")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mini Chamet"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _startCall(context),
              child: const Text("Start Video Call"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _copyLink(context),
              child: const Text("Copy Room Link"),
            ),
          ],
        ),
      ),
    );
  }
}
