import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../../core/constant/app_colors.dart';

class ReportDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> report;

  const ReportDetailsScreen({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB), // Cleaner neutral background
      body: Stack(
        children: [
          // Background Gradient Layer to match Trip Details
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primaryYellow.withOpacity(0.15),
                    const Color(0xFFF8F9FB),
                  ],
                  stops: const [0.0, 0.4],
                ),
              ),
            ),
          ),

          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              _buildSliverAppBar(context),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Status Hero Card
                      _buildStatusHeroCard(),
                      const SizedBox(height: 24),

                      _buildSectionLabel("INCIDENT INFORMATION"),
                      _buildContentCard(
                        child: Column(
                          children: [
                            _buildModernDetailRow(
                              Icons.badge_outlined,
                              "Driver ID",
                              report['driver_id'] ?? "N/A",
                            ),
                            _buildDivider(),
                            _buildModernDetailRow(
                              Icons.numbers_rounded,
                              "Trip Reference",
                              report['trip_uuid'] ?? "N/A",
                              isCopyable: true,
                              context: context,
                            ),
                            _buildDivider(),
                            _buildModernDetailRow(
                              Icons.calendar_today_rounded,
                              "Reported On",
                              _formatFullDate(report['reported_at']),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      _buildSectionLabel("ISSUE DESCRIPTION"),
                      _buildNarrativeCard(),

                      if (report['evidence_url'] != null &&
                          report['evidence_url'].isNotEmpty) ...[
                        const SizedBox(height: 24),
                        _buildSectionLabel("ATTACHED EVIDENCE"),
                        _buildProEvidenceGallery(),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      pinned: true,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 18,
          color: AppColors.darkNavy,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        "CASE #${report['id'] ?? '---'}",
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w900,
          letterSpacing: 2.0,
          color: AppColors.darkNavy,
        ),
      ),
    );
  }

  Widget _buildStatusHeroCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.darkNavy,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkNavy.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildStatusBadge(report['status'] ?? "pending"),
          const SizedBox(height: 16),
          Text(
            (report['issue_type'] ?? "General").toString().toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Incident Logged via Passenger App",
            style: TextStyle(
              color: Colors.white54,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          color: AppColors.textGrey.withOpacity(0.7),
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildContentCard({required Widget child}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildModernDetailRow(
    IconData icon,
    String label,
    String value, {
    bool isCopyable = false,
    BuildContext? context,
  }) {
    return InkWell(
      onTap: isCopyable
          ? () {
              Clipboard.setData(ClipboardData(text: value));
              HapticFeedback.lightImpact();
              ScaffoldMessenger.of(context!).showSnackBar(
                const SnackBar(
                  content: Text("Reference Copied"),
                  duration: Duration(seconds: 1),
                ),
              );
            }
          : null,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, size: 18, color: AppColors.textGrey),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textGrey,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Expanded(
              child: Text(
                value,
                textAlign: TextAlign.end,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.darkNavy,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            if (isCopyable) ...[
              const SizedBox(width: 8),
              const Icon(
                Icons.copy_rounded,
                size: 14,
                color: Colors.blueAccent,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNarrativeCard() {
    return _buildContentCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          report['description'] ?? "No details provided.",
          style: TextStyle(
            fontSize: 14,
            height: 1.6,
            color: AppColors.darkNavy.withOpacity(0.8),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildProEvidenceGallery() {
    final String path = report['evidence_url'];
    final bool isLocal = !path.startsWith('http');

    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
        image: DecorationImage(
          image: isLocal
              ? FileImage(File(path))
              : NetworkImage(path) as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
          ),
        ),
        padding: const EdgeInsets.all(16),
        alignment: Alignment.bottomRight,
        child: const CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(Icons.fullscreen_rounded, color: AppColors.darkNavy),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color = const Color(0xFFF59E0B);
    if (status.toLowerCase() == 'resolved') color = const Color(0xFF10B981);
    if (status.toLowerCase() == 'investigating')
      color = const Color(0xFF3B82F6);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w900,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildDivider() => Divider(
    height: 1,
    color: Colors.grey.withOpacity(0.1),
    indent: 16,
    endIndent: 16,
  );

  String _formatFullDate(String? dateStr) {
    if (dateStr == null) return "N/A";
    try {
      final date = DateTime.parse(dateStr).toLocal();
      return DateFormat('MMM dd, yyyy • hh:mm a').format(date);
    } catch (e) {
      return dateStr;
    }
  }
}
