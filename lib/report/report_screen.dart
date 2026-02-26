import 'package:flutter/material.dart';
import '../core/constant/app_colors.dart';
import 'widgets/reason_dropdown.dart';
import 'widgets/details_input.dart';
import 'widgets/submit_button.dart';

class ReportScreen extends StatefulWidget {
  final Map<String, dynamic> trip;

  const ReportScreen({super.key, required this.trip});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final TextEditingController _detailsController = TextEditingController();
  String? _selectedReason;

  final List<String> _reasons = [
    "Incorrect Fare",
    "Driver Behavior",
    "Vehicle Issue",
    "Route Issue",
    "Other",
  ];

  void _handleSubmit() {
    if (_selectedReason == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please select a reason")));
      return;
    }

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Report submitted successfully."),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primaryYellow.withOpacity(0.2),
              Colors.white,
              AppColors.primaryYellow.withOpacity(0.1),
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Column(
                  children: [
                    ReasonDropdown(
                      value: _selectedReason,
                      reasons: _reasons,
                      onChanged: (val) => setState(() => _selectedReason = val),
                    ),
                    const SizedBox(height: 24),
                    DetailsInput(controller: _detailsController),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SubmitButton(onPressed: _handleSubmit),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        "REPORT TRIP",
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.2,
          color: AppColors.darkNavy,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 18,
          color: AppColors.darkNavy,
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
