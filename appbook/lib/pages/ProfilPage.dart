import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Dummy user data for demonstration
  final String profilePictureUrl = "https://via.placeholder.com/150"; // Replace with actual URL
  final String userName = "amanda tri ayu";
  final String userEmail = "amanda tri ayu.com";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Custom exit confirmation logic
        return true; // Allow back navigation
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.add_a_photo, color: Colors.grey),
            onPressed: () {
              // Logic to upload profile picture
            },
          ),
          title: const Text("PROFILE"),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.grey),
              onPressed: () {
                // Logic for signing out
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    foregroundImage: NetworkImage(profilePictureUrl), // Using NetworkImage
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(userName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text(userEmail, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ProfileTile(name: "My Orders", description: "Already have 10 orders", onTap: () {
                // Navigate to Orders Screen
              }),
              const SizedBox(height: 20),
              ProfileTile(name: "Shipping Addresses", description: "2 Addresses", onTap: () {
                // Navigate to Shipping Address Screen
              }),
              const SizedBox(height: 20),
              ProfileTile(name: "Payment Method", description: "You have 3 cards", onTap: () {
                // Navigate to Payment Methods Screen
              }),
              const SizedBox(height: 20),
              ProfileTile(name: "My Reviews", description: "Reviews for 5 items", onTap: () {
                // Navigate to Reviews Screen
              }),
              const SizedBox(height: 20),
              ProfileTile(name: "Settings", description: "Notifications, Password, FAQ, Contact", onTap: () {
                // Navigate to Settings Screen
              }),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  final String name;
  final String description;
  final VoidCallback onTap;

  const ProfileTile({required this.name, required this.description, required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 5),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 5),
                Text(description, style: const TextStyle(color: Colors.grey)),
              ],
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}