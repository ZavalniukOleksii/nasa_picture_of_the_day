import 'package:flutter/material.dart';

class FullSizeImagePage extends StatelessWidget {
  final String url;

  const FullSizeImagePage({required this.url, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Image.network(url),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('return to the previous page'),
            ),
          ],
        ),
      ),
    );
  }
}
