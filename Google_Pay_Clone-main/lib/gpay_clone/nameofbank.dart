import 'package:flutter/material.dart';

class BankId extends StatefulWidget {
  const BankId({Key? key}) : super(key: key);

  @override
  _BankIdState createState() => _BankIdState();
}

class _BankIdState extends State<BankId> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Bank ID'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'Enter Bank ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String bankId = _textController.text;
                Navigator.pop(context, bankId); // Pass back data to previous screen
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
