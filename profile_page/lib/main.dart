import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 50.0,
              backgroundImage:  AssetImage('assets/profile_image.jpg'), // Add your image asset
            ),
            const SizedBox(height: 20.0),
            const Text(
              'John Doe',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'john.doe@example.com',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20.0),
            const ListTile(
              leading: Icon(Icons.account_balance_wallet),
              title: Text('Total Budget'),
              subtitle: Text('\$5,000.00'),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.attach_money),
              title: Text('Remaining Budget'),
              subtitle: Text('\$2,500.00'),
            ),
            const Divider(),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Add logout functionality here
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
