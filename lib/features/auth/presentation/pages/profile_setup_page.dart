import 'package:flutter/material.dart';

class ProfileSetupPage extends StatelessWidget {
  const ProfileSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Setup')),
      body: const Center(
        child: Text('Profile Setup Page'),
      ),
    );
  }
}
