import 'package:example/config/app_widgets.dart';
import 'package:example/page/auth/login/login_view.dart';
import 'package:example/toggle/patients/patients_view.dart';
import 'package:flutter/material.dart';
import '../../../config/app_theme.dart';
import '../../../data/app_data.dart';

class ProfileView extends StatefulWidget {
  static const routeName = '/profile';
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          // User info card
          AppCard(child: Row(children: [
            Container(
              width: 60, height: 60,
              decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppColors.primary, AppColors.accent]), shape: BoxShape.circle),
              child: const Center(child: Text('RH', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 20))),
            ),
            const SizedBox(width: 14),
            const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Rahim Hossain', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: AppColors.textDark)),
              Text('+880 17XX XXX XXX', style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
              Text('rahim@email.com', style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
            ])),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(8)),
              child: const Text('Edit', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600, fontSize: 13)),
            ),
          ])),

          const SizedBox(height: 20),

          // Stats
          Row(children: [
            _statCard('📋', '6', 'Bookings'),
            const SizedBox(width: 12),
            _statCard('📄', '4', 'Reports'),
            const SizedBox(width: 12),
            _statCard('👨‍👩‍👦', '4', 'Patients'),
          ]),

          const SizedBox(height: 20),

          // Patients
          SectionTitle('Family Members', actionLabel: 'Manage', onAction: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PatientsView()))),
          const SizedBox(height: 12),
          ...AppData.patients.map((p) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              leading: Container(
                width: 40, height: 40,
                decoration: BoxDecoration(color: AppColors.primaryLight, shape: BoxShape.circle),
                child: Center(child: Text(p.name[0], style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w800))),
              ),
              title: Text(p.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: AppColors.textDark)),
              subtitle: Text('${p.relation} • ${p.age} yrs • ${p.bloodGroup}', style: const TextStyle(color: AppColors.textGrey, fontSize: 12)),
              trailing: const Icon(Icons.chevron_right, color: AppColors.textGrey),
            ),
          )),

          const SizedBox(height: 20),

          // Settings
          const Align(alignment: Alignment.centerLeft, child: Text('Settings', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.textDark))),
          const SizedBox(height: 12),

          _settingsItem(Icons.notifications_outlined, 'Notifications', onTap: () {}),
          _settingsItem(Icons.language_outlined, 'Language', trailing: const Text('English', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)), onTap: () {}),
          _settingsItem(
            Icons.dark_mode_outlined, 'Dark Mode',
            trailing: Switch(value: _darkMode, onChanged: (v) => setState(() => _darkMode = v), activeColor: AppColors.primary),
            onTap: () {},
          ),
          _settingsItem(Icons.help_outline, 'Help & Support', onTap: () {}),
          _settingsItem(Icons.info_outline, 'About App', onTap: () {}),

          const SizedBox(height: 16),

          FullButton('Logout', outlined: true, color: AppColors.danger, onTap: () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginView()), (_) => false);
          }),

          const SizedBox(height: 20),
        ]),
      ),
    );
  }

  Widget _statCard(String emoji, String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.divider)),
        child: Column(children: [
          Text(emoji, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 20, color: AppColors.textDark)),
          Text(label, style: const TextStyle(color: AppColors.textGrey, fontSize: 11)),
        ]),
      ),
    );
  }

  Widget _settingsItem(IconData icon, String title, {Widget? trailing, required VoidCallback onTap}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      leading: Icon(icon, color: AppColors.primary, size: 22),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: AppColors.textDark)),
      trailing: trailing ?? const Icon(Icons.chevron_right, color: AppColors.textGrey),
      onTap: onTap,
    );
  }
}
