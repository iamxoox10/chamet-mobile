import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Live Chat MVP',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.purple),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _name, decoration: const InputDecoration(labelText: 'Username')),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () {
                final name = _name.text.trim().isEmpty ? 'Guest' : _name.text.trim();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen(username: name)));
              },
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String username;
  const HomeScreen({super.key, required this.username});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Discover')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          _userCard(context, 'Alice', 'US'),
          _userCard(context, 'Bob', 'IN'),
          _userCard(context, 'Sophia', 'UK'),
        ],
      ),
    );
  }

  Widget _userCard(BuildContext context, String name, String country) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.person)),
        title: Text(name),
        subtitle: Text('Country: $country'),
        trailing: FilledButton(
          onPressed: () => _startCall(name),
          child: const Text('Call'),
        ),
      ),
    );
  }

  Future<void> _startCall(String peerName) async {
    // Simple, instant real-time test using Jitsi (works without any backend)
    final room = 'room${DateTime.now().millisecondsSinceEpoch}';
    final url = Uri.parse('https://meet.jit.si/$room#config.prejoinPageEnabled=false');
    final ok = await canLaunchUrl(url);
    if (!ok) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cannot open call page')));
      }
      return;
    }
    await launchUrl(url, mode: LaunchMode.inAppBrowserView);
  }
}
