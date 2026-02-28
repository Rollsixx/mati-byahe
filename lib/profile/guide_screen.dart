import 'package:flutter/material.dart';
import '../core/constant/app_colors.dart';

class GuideScreen extends StatelessWidget {
  final String role;

  const GuideScreen({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    bool isDriver = role.toLowerCase() == 'driver';

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        title: const Text(
          "APP GUIDE",
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.auto_awesome, color: Colors.white, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isDriver ? "Driver Guide" : "Passenger Guide",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Learn how to use the platform effectively.",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "STEP BY STEP",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: Colors.grey,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            if (isDriver) ...[
              _buildStep(
                "1",
                "Go Online",
                "Activate your status to start receiving nearby ride requests from passengers.",
              ),
              _buildStep(
                "2",
                "Accept Jobs",
                "View pickup locations and estimated earnings before accepting a passenger request.",
              ),
              _buildStep(
                "3",
                "Complete Trip",
                "Follow the map to the destination and complete the trip to receive payment.",
              ),
            ] else ...[
              _buildStep(
                "1",
                "Set Destination & Fare",
                "Enter your destination to instantly see the calculated fare before you book your ride.",
              ),
              _buildStep(
                "2",
                "QR Smart Scan",
                "Scan the QR code at designated stations to instantly see and connect with drivers at your current location.",
              ),
              _buildStep(
                "3",
                "Confirm & Ride",
                "Review driver details, confirm the fare, and enjoy a safe journey to your destination.",
              ),
            ],
            const SizedBox(height: 30),
            const Text(
              "OUR PURPOSE",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: Colors.grey,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black.withOpacity(0.05)),
              ),
              child: const Text(
                "Our platform is designed to provide a safe, transparent, and efficient transportation ecosystem. We connect passengers with verified drivers to ensure reliable travel for the local community.",
                style: TextStyle(
                  fontSize: 13,
                  height: 1.5,
                  color: AppColors.darkNavy,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(String num, String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              num,
              style: const TextStyle(
                color: AppColors.primaryBlue,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  desc,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
