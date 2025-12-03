import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String? userId;
  final bool isAuthReady;

  const ProfileScreen({super.key, required this.userId, required this.isAuthReady});

  String _getAuthStatusText() {
    if (!isAuthReady) {
      return 'Connecting...';
    }
    return userId != null ? 'Online (Authenticated)' : 'Local Mode';
  }

  Color _getAuthStatusColor() {
    if (!isAuthReady) {
      return Colors.amber.shade600;
    }
    return userId != null ? Colors.green.shade600 : Colors.red.shade600;
  }

  Widget _buildStatusIndicator(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                margin: const EdgeInsets.only(right: 8),
              ),
              Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color)),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildActionTile(IconData icon, String title, VoidCallback onTap, String? subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.indigo.shade600),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey.shade800)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (subtitle != null)
              Text(
                subtitle,
                style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
              ),
            const SizedBox(width: 8),
            Icon(Icons.chevron_right, color: Colors.grey.shade400),
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'App Settings & Status', // Cleaned up the title
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF1F2937)),
            ),
          ),
          const SizedBox(height: 20),
          
          const Text(
            'Connection Status',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF1F2937)),
          ),
          const SizedBox(height: 10),
          _buildStatusIndicator(
            'Authentication Status',
            _getAuthStatusText(),
            _getAuthStatusColor(),
          ),
          if (userId != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: _buildStatusIndicator(
                'User ID',
                userId!,
                Colors.grey.shade600,
              ),
            ),
          const SizedBox(height: 24),

          const Text(
            'App Preferences',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF1F2937)),
          ),
          const SizedBox(height: 10),
          _buildActionTile(
            Icons.dark_mode_outlined,
            'Theme Mode',
            () {}, // Placeholder action
            'System Default',
          ),
          _buildActionTile(
            Icons.notifications_none,
            'Notifications',
            () {}, // Placeholder action
            'On',
          ),
          _buildActionTile(
            Icons.language,
            'Language',
            () {}, // Placeholder action
            'English (US)',
          ),
          const SizedBox(height: 24),

          const Text(
            'Support & Legal',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF1F2937)),
          ),
          const SizedBox(height: 10),
          _buildActionTile(
            Icons.help_outline,
            'Help Center',
            () {}, // Placeholder action
            null,
          ),
          _buildActionTile(
            Icons.privacy_tip_outlined,
            'Privacy Policy',
            () {}, // Placeholder action
            null,
          ),
          _buildActionTile(
            Icons.description_outlined,
            'Terms of Service',
            () {}, // Placeholder action
            null,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}