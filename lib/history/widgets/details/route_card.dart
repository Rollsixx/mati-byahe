import 'package:flutter/material.dart';
import '../../../core/constant/app_colors.dart';

class RouteCard extends StatelessWidget {
  final String pickup;
  final String dropOff;

  const RouteCard({super.key, required this.pickup, required this.dropOff});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.softWhite),
      ),
      child: Row(
        children: [
          Column(
            children: [
              const Icon(Icons.circle, size: 8, color: AppColors.primaryBlue),
              Container(
                width: 1,
                height: 40,
                color: AppColors.textGrey.withOpacity(0.3),
              ),
              const Icon(Icons.location_on, size: 12, color: Colors.redAccent),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRoutePoint("From", pickup),
                const SizedBox(height: 24),
                _buildRoutePoint("To", dropOff),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoutePoint(String label, String address) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 9,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          address,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.darkNavy,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
