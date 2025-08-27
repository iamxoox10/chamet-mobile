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
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _startCall(BuildContext context) async {
    final roomUrl = "https://meet.jit.si/testchametroom";
    if (await canLaunchUrl(Uri.parse(roomUrl))) {
      await launchUrl(Uri.parse(roomUrl), mode: LaunchMode.inAppWebView);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not launch call")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mini Chamet")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _startCall(context),
          child: const Text("Start Video Call"),
        ),
      ),
    );
  }
}
