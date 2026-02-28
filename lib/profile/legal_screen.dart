import 'package:flutter/material.dart';
import '../core/constant/app_colors.dart';

class LegalScreen extends StatelessWidget {
  const LegalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        title: const Text(
          "LEGAL & PRIVACY",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: AppColors.darkNavy,
        elevation: 0.5,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        children: [
          _buildLegalSection(
            "Terms of Service",
            "By using this application, you agree to comply with our terms. We provide a platform for transportation services and are not liable for direct disputes between users beyond platform functionality.",
          ),
          const SizedBox(height: 15),
          _buildLegalSection(
            "Privacy Policy",
            "We collect location data to facilitate ride matching and safety tracking. Your personal information is encrypted and never sold to third parties.",
          ),
          const SizedBox(height: 15),
          _buildLegalSection(
            "User Conduct",
            "All users, both drivers and passengers, are expected to maintain professionalism. Harassment or illegal activities will result in immediate account termination.",
          ),
          const SizedBox(height: 30),
          const Center(
            child: Text(
              "Version 1.0.0",
              style: TextStyle(color: Colors.grey, fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegalSection(String title, String content) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: AppColors.primaryBlue,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 13,
              height: 1.5,
              color: AppColors.darkNavy,
            ),
          ),
        ],
      ),
    );
  }
}
