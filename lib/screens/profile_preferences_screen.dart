import 'package:flutter/material.dart';

class ProfilePreferencesScreen extends StatefulWidget {
  const ProfilePreferencesScreen({super.key});

  @override
  State<ProfilePreferencesScreen> createState() =>
      _ProfilePreferencesScreenState();
}

class _ProfilePreferencesScreenState extends State<ProfilePreferencesScreen> {
  bool darkMode = false;
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Profile & Preferences",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Profile Info
              const CircleAvatar(
                radius: 35,
                backgroundColor: Color(0xFFD1C4E9),
                child: Icon(Icons.person, size: 40, color: Colors.purple),
              ),
              const SizedBox(height: 12),
              const Text(
                "Muhammad Hamza",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "mh6349464@gmail.com",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 30),

              // Theme Toggle
              SwitchListTile(
                title: const Text(
                  "Dark Mode",
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                ),
                value: darkMode,
                activeColor: Colors.purple,
                onChanged: (val) {
                  setState(() => darkMode = val);
                },
              ),

              // Notification Toggle
              SwitchListTile(
                title: const Text(
                  "Notifications",
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                ),
                value: notificationsEnabled,
                activeColor: Colors.purple,
                onChanged: (val) {
                  setState(() => notificationsEnabled = val);
                },
              ),
              const SizedBox(height: 20),

              // Account Options
              const Divider(),
              const SizedBox(height: 10),

              ElevatedButton.icon(
                icon: const Icon(Icons.edit, size: 18),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                label: const Text("Edit Profile"),
              ),
              const SizedBox(height: 10),

              ElevatedButton.icon(
                icon: const Icon(Icons.lock_outline, size: 18),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple.shade100,
                  foregroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                label: const Text("Change Password"),
              ),
              const SizedBox(height: 10),

              ElevatedButton.icon(
                icon: const Icon(Icons.logout, size: 18),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade100,
                  foregroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                label: const Text("Logout"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
