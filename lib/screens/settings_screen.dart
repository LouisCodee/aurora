import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../widgets/shared_widgets.dart';

class SettingsScreen extends StatefulWidget {
  final bool isInternal;
  const SettingsScreen({super.key, this.isInternal = false});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = true;
  bool _darkMode = true;
  bool _biometrics = false;

  @override
  Widget build(BuildContext context) {
    Widget body = Stack(
        children: [
          // Background Glow
          Positioned(
            bottom: -100,
            right: -100,
            child: GlowDot(size: 300, color: AuroraColors.accent),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 32),
                        const Text('System Settings', style: AuroraTextStyles.heading1),
                        const SizedBox(height: 8),
                        const Text('Manage your preferences and security.', style: AuroraTextStyles.body),
                        const SizedBox(height: 40),
                        _buildSectionHeader('Profile'),
                        const SizedBox(height: 16),
                        _buildProfileCard(),
                        const SizedBox(height: 40),
                        _buildSectionHeader('Preferences'),
                        const SizedBox(height: 16),
                        _buildSettingsToggle('Push Notifications', 'Real-time task alerts', _notifications, (val) => setState(() => _notifications = val)),
                        const SizedBox(height: 16),
                        _buildSettingsToggle('Aesthetic Dark Mode', 'Optimized for high-end displays', _darkMode, (val) => setState(() => _darkMode = val)),
                        const SizedBox(height: 16),
                        _buildSettingsToggle('Biometric Access', 'FaceID or Fingerprint', _biometrics, (val) => setState(() => _biometrics = val)),
                        const SizedBox(height: 40),
                        _buildSectionHeader('Support'),
                        const SizedBox(height: 16),
                        _buildSettingsAction('Help Center', Icons.help_outline_rounded),
                        const SizedBox(height: 12),
                        _buildSettingsAction('Terms of Service', Icons.description_outlined),
                        const SizedBox(height: 48),
                        AuroraButton(
                          text: 'Log Out',
                          onPressed: () => Navigator.pushReplacementNamed(context, '/onboarding'),
                          isPrimary: false,
                        ),
                        const SizedBox(height: 120),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      );

    if (widget.isInternal) return body;
    return Scaffold(
      backgroundColor: AuroraColors.background,
      body: body,
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AuroraColors.surfaceLight,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AuroraColors.divider),
          ),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 18,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(title, style: AuroraTextStyles.heading3);
  }

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AuroraDecorations.glowCard(),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AuroraColors.accent, width: 2),
            ),
            child: const CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=luis'),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Luis Fernandez',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text('luis.f@aurora.io', style: AuroraTextStyles.bodySmall),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AuroraColors.accentDim,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'PRO',
              style: TextStyle(
                color: AuroraColors.accent,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsToggle(String title, String subtitle, bool value, Function(bool) onChanged) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AuroraDecorations.glowCard(radius: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 2),
              Text(subtitle, style: AuroraTextStyles.bodySmall),
            ],
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeTrackColor: AuroraColors.accent.withValues(alpha: 0.3),
            activeThumbColor: AuroraColors.accent,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsAction(String title, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AuroraDecorations.glowCard(radius: 16),
      child: Row(
        children: [
          Icon(icon, color: AuroraColors.textDim, size: 20),
          const SizedBox(width: 16),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          const Icon(Icons.chevron_right_rounded, color: AuroraColors.textDim),
        ],
      ),
    );
  }
}
