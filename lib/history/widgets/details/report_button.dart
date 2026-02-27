import 'package:flutter/material.dart';
import '../../../components/confirmation_dialog.dart';
import '../../../report/report_screen.dart';
import '../../../core/database/local_database.dart';

class ReportButton extends StatelessWidget {
  final Map<String, dynamic> trip;

  const ReportButton({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: LocalDatabase().isTripReported(trip['uuid']),
      builder: (context, snapshot) {
        final bool isReported = snapshot.data ?? false;

        return Container(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 30),
          color: Colors.transparent,
          child: OutlinedButton(
            onPressed: isReported ? null : () => _handleReportClick(context),
            style: OutlinedButton.styleFrom(
              foregroundColor: isReported ? Colors.grey : Colors.redAccent,
              backgroundColor: Colors.transparent,
              side: BorderSide(
                color: isReported
                    ? Colors.grey.withOpacity(0.3)
                    : Colors.redAccent,
                width: 1.2,
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isReported
                      ? Icons.check_circle_outline
                      : Icons.warning_amber_rounded,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  isReported ? "TRIP ALREADY REPORTED" : "REPORT THIS TRIP",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleReportClick(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ConfirmationDialog(
        title: "Report Trip",
        content: "Are you sure you want to report this trip?",
        confirmText: "Report",
        onConfirm: () => _navigateToReport(context),
      ),
    );
  }

  void _navigateToReport(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => ReportScreen(trip: trip)));
  }
}
