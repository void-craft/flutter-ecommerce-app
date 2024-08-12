import 'package:bagit/screens/base/base.dart';
import 'package:bagit/widgets/appbar/custom_appbar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> _signOutAndNavigate() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    if (mounted) {
      _showLogoutDialog();
    }
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logged Out'),
          content: const Text('You have been successfully logged out.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const BaseApp()),
                );
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final screenSize = MediaQuery.of(context).size;
    final double padding = screenSize.width * 0.04;

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Profile',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUserInfoCard(user, padding),
            SizedBox(height: padding),
            _buildOrderHistoryCard(padding),
            SizedBox(height: padding),
            _buildAddressBookCard(padding),
            SizedBox(height: padding),
            _buildSettingsCard(padding),
            SizedBox(height: padding),
            _buildLogoutButton(screenSize, padding),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoCard(User? user, double padding) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('User Information', padding),
            _buildInfoText('Name: ${user?.displayName ?? 'Guest'}', padding),
            _buildInfoText('Email: ${user?.email ?? 'Not Available'}', padding),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderHistoryCard(double padding) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Order History', padding),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Order #${index + 1}'),
                  subtitle: const Text('Status: Delivered'),
                  trailing: TextButton(
                    child: const Text('View Details'),
                    onPressed: () {},
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressBookCard(double padding) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Address Book', padding),
            _buildAddressTile('Home Address', '123 Main Street, City, Country', padding),
            _buildAddressTile('Billing Address', '456 Another St, City, Country', padding),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Add New Address'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsCard(double padding) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Settings', padding),
            ListTile(
              title: const Text(
                'Delete Account',
                style: TextStyle(color: Colors.red),
              ),
              leading: const Icon(Icons.delete, color: Colors.red),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(Size screenSize, double padding) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.1,
            vertical: padding * 0.75,
          ),
        ),
        onPressed: _signOutAndNavigate,
        child: const Text(
          'Logout',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, double padding) {
    return Padding(
      padding: EdgeInsets.only(bottom: padding / 2),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInfoText(String text, double padding) {
    return Padding(
      padding: EdgeInsets.only(bottom: padding / 4),
      child: Text(text),
    );
  }

  Widget _buildAddressTile(String title, String subtitle, double padding) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () {},
      ),
    );
  }
}
