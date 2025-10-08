import 'package:event_countdown_app/screens/eventcountdownscreen2.dart';
import 'package:flutter/material.dart';
 // import screen 2

class EventCountdownScreen1 extends StatelessWidget {
  const EventCountdownScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6FA), // cream
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 60),
              const Text(
                "EVENT COUNTDOWN",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Track Events Easily",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 80),
              const Text("0", style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              const Icon(Icons.arrow_downward, size: 36),
              const SizedBox(height: 20),
              const Text("365", style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: ElevatedButton(
                  onPressed: () {
                    // 👇 Navigate to screen 2
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EventCountdownScreen2(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFA961C3), // purple
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: const Text(
                    "Get Started",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
