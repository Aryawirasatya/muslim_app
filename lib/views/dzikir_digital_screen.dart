import 'package:flutter/material.dart';

class DzikirDigitalScreen extends StatefulWidget {
  @override
  _DzikirDigitalScreenState createState() => _DzikirDigitalScreenState();
}

class _DzikirDigitalScreenState extends State<DzikirDigitalScreen> {
  int counter = 0;

  void _increment() {
    setState(() => counter++);
  }

  void _reset() {
    setState(() => counter = 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dzikir Digital"),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Jumlah Dzikir", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 12),
            Text("$counter", style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _increment,
              child: const Text("Tambah"),
            ),
            TextButton(
              onPressed: _reset,
              child: const Text("Reset"),
            ),
          ],
        ),
      ),
    );
  }
}
