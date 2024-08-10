import 'package:buy_it_app/widgets/appbar/custom_appbar_widget.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen size to make the layout responsive
    final screenSize = MediaQuery.of(context).size;
    
    // Calculate padding and font sizes based on screen width
    double padding = screenSize.width * 0.04;
    double fontSizeTitle = screenSize.width * 0.045;
    double fontSizeContent = screenSize.width * 0.04;

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Profile'
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Information Section
            Card(
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'User Information',
                      style: TextStyle(
                        fontSize: fontSizeTitle,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: padding / 2),
                    Text(
                      'Name: John Doe',  // Replace with the actual user name
                      style: TextStyle(fontSize: fontSizeContent),
                    ),
                    SizedBox(height: padding / 4),
                    Text(
                      'Email: johndoe@example.com',  // Replace with the actual user email
                      style: TextStyle(fontSize: fontSizeContent),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: padding),

            // Order History Section
            Card(
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order History',
                      style: TextStyle(
                        fontSize: fontSizeTitle,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: padding / 2),
                    ListView.builder(
                      shrinkWrap: true,  // Use shrinkWrap to ensure the ListView fits within the column
                      physics: const NeverScrollableScrollPhysics(),  // Prevent nested scrolling
                      itemCount: 5,  // Replace with actual order count
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            'Order #${index + 1}',
                            style: TextStyle(fontSize: fontSizeContent),
                          ),
                          subtitle: Text(
                            'Status: Delivered',  // Replace with actual status
                            style: TextStyle(fontSize: fontSizeContent * 0.9),
                          ),
                          trailing: TextButton(
                            child: Text(
                              'View Details',
                              style: TextStyle(fontSize: fontSizeContent * 0.9),
                            ),
                            onPressed: () {
                              // Navigate to order details screen
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: padding),

            // Address Book Section
            Card(
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Address Book',
                      style: TextStyle(
                        fontSize: fontSizeTitle,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: padding / 2),
                    ListTile(
                      title: Text(
                        'Home Address',
                        style: TextStyle(fontSize: fontSizeContent),
                      ),
                      subtitle: Text(
                        '123 Main Street, City, Country',
                        style: TextStyle(fontSize: fontSizeContent * 0.9),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.edit,
                          size: fontSizeContent,
                        ),
                        onPressed: () {
                          // Edit address functionality
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Billing Address',
                        style: TextStyle(fontSize: fontSizeContent),
                      ),
                      subtitle: Text(
                        '456 Another St, City, Country',
                        style: TextStyle(fontSize: fontSizeContent * 0.9),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.edit,
                          size: fontSizeContent,
                        ),
                        onPressed: () {
                          // Edit billing address functionality
                        },
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        // Add new address functionality
                      },
                      icon: Icon(Icons.add, size: fontSizeContent),
                      label: Text(
                        'Add New Address',
                        style: TextStyle(fontSize: fontSizeContent),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: padding),

            // Settings Section
            Card(
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: fontSizeTitle,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: padding / 2),
                    ListTile(
                      title: Text(
                        'Delete Account',
                        style: TextStyle(
                          fontSize: fontSizeContent,
                          color: Colors.red,
                        ),
                      ),
                      leading: Icon(Icons.delete, color: Colors.red, size: fontSizeContent),
                      onTap: () {
                        // Handle delete account
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: padding),

            // Logout Button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.1,
                    vertical: padding * 0.75,
                  ),
                ),
                onPressed: () {
                  // Handle logout functionality
                },
                child: Text(
                  'Logout',
                  style: TextStyle(fontSize: fontSizeContent),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
