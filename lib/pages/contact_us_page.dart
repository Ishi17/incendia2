import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatelessWidget {
  final String phone = '+91-6361596877';
  final String email = ''; // intentionally left blank
  final String addressUrl = 'https://maps.app.goo.gl/m6bMEkJgmfFU8QcBA';
  final String whatsapp = '+91-6361596877';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
        backgroundColor: Color(0xFF002B5B),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Get in Touch', style: theme.headlineLarge, textAlign: TextAlign.center),
              SizedBox(height: 40),
              _buildInlineContactRow(
                icon: Icons.phone,
                label: 'Phone',
                value: phone,
                onTap: () => launchUrl(Uri.parse('tel:$phone')),
              ),
              if (email.isNotEmpty)
                _buildInlineContactRow(
                  icon: Icons.email,
                  label: 'Email',
                  value: email,
                  onTap: () => launchUrl(Uri.parse('mailto:$email')),
                ),
              _buildInlineContactRow(
                icon: Icons.location_on,
                label: 'Address',
                value: 'Google Maps',
                onTap: () => launchUrl(Uri.parse(addressUrl)),
              ),
              _buildInlineContactRow(
                icon: Icons.message,
                label: 'WhatsApp',
                value: whatsapp,
                onTap: () => launchUrl(Uri.parse('https://wa.me/916361596877')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInlineContactRow({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Color(0xFFFF6B00), size: 24),
            SizedBox(width: 8),
            Text(
              '$label: ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Color(0xFF002B5B),
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF666666),
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
