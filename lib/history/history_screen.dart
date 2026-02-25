import 'package:flutter/material.dart';
import '../core/database/local_database.dart';
import 'widgets/history_header.dart';
import 'widgets/history_tile.dart'; // Import the new tile

class HistoryScreen extends StatefulWidget {
  final String email;
  const HistoryScreen({super.key, required this.email});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const HistoryHeader(),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: LocalDatabase().getTrips(widget.email),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }

                final trips = snapshot.data ?? [];

                if (trips.isEmpty) {
                  return _buildEmptyState();
                }

                return ListView.builder(
                  padding:
                      EdgeInsets.zero, // Remove padding for full-width tiles
                  itemCount: trips.length,
                  itemBuilder: (context, index) {
                    return HistoryTile(trip: trips[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Text("No past trips found", style: TextStyle(color: Colors.grey)),
    );
  }
}
