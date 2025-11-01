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
      backgroundColor: const Color(0xFFFDF6FA), // same as other screens
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            const Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Color(0xFFD1C4E9),
                    child: Icon(Icons.person, size: 45, color: Colors.purple),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Hamza",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "hamza@example.com",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Preferences Section
            const Text(
              "Preferences",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),

            // Theme Toggle
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(
                "Theme",
                style: TextStyle(fontFamily: 'Poppins', fontSize: 14),
              ),
              value: darkMode,
              activeColor: Colors.purple,
              onChanged: (val) {
                setState(() => darkMode = val);
              },
            ),

            // Notification Toggle
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(
                "Notification",
                style: TextStyle(fontFamily: 'Poppins', fontSize: 14),
              ),
              trailing: Switch(
                value: notificationsEnabled,
                activeColor: Colors.purple,
                onChanged: (val) {
                  setState(() => notificationsEnabled = val);
                },
              ),
            ),

            const SizedBox(height: 30),

            // Account Section
            const Text(
              "Account",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),

            // Edit Profile
            _buildActionTile(Icons.edit, "Edit Profile", () {}),
            const SizedBox(height: 10),

            // Change Password
            _buildActionTile(Icons.lock_outline, "Change Password", () {}),
            const SizedBox(height: 10),

            // Logout
            _buildActionTile(Icons.logout, "Logout", () {},
                color: Colors.red, isLogout: true),
          ],
        ),
      ),
    );
  }

  Widget _buildActionTile(IconData icon, String label, VoidCallback onTap,
      {Color color = Colors.purple, bool isLogout = false}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            if (!isLogout)
              const Icon(Icons.keyboard_arrow_right, color: Colors.black54),
          ],
        ),
      ),
    );
  }
}
