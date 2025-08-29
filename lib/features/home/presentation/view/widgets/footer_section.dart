import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Brand Section - Simple but elegant
            _buildBrandSection(),

            const SizedBox(height: 40),

            // Navigation Links
            _buildNavigationSection(),

            const SizedBox(height: 32),

            // Social Media Section
            _buildSocialSection(),

            const SizedBox(height: 32),

            // Contact Info
            _buildContactSection(),

            const SizedBox(height: 32),

            // Simple divider
            Container(
              height: 1,
              width: 200,
              color: Colors.white.withOpacity(0.2),
            ),

            const SizedBox(height: 24),

            // Copyright Section
            _buildCopyrightSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandSection() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFF4A90E2), Color(0xFF7B68EE)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4A90E2).withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(Icons.landscape, size: 40, color: Colors.white),
        ),
        const SizedBox(height: 16),
        ShaderMask(
          shaderCallback:
              (bounds) => const LinearGradient(
                colors: [Color(0xFF4A90E2), Color(0xFF7B68EE)],
              ).createShader(bounds),
          child: const Text(
            'Sharm Desert Safari',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Unforgettable Adventures in the Heart of Egypt',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade300,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildNavigationSection() {
    final links = [
      {
        'text': 'Desert Tours',
        'url':
            'https://www.instagram.com/sharmdesertsafari?igsh=MWIwYXF3MnIzeDdwcg%3D%3D&utm_source=qr',
      },
      {
        'text': 'About Us',
        'url':
            'https://www.instagram.com/sharmdesertsafari?igsh=MWIwYXF3MnIzeDdwcg%3D%3D&utm_source=qr',
      },
      {
        'text': 'Gallery',
        'url':
            'https://www.facebook.com/profile.php?id=61575163371185&mibextid=wwXIfr&mibextid=wwXIfr',
      },
      {
        'text': 'Contact',
        'url':
            'https://www.facebook.com/profile.php?id=61575163371185&mibextid=wwXIfr&mibextid=wwXIfr',
      },
    ];

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 40,
      runSpacing: 16,
      children:
          links
              .map(
                (link) =>
                    OptimizedFooterLink(text: link['text']!, url: link['url']!),
              )
              .toList(),
    );
  }

  Widget _buildSocialSection() {
    return Column(
      children: [
        Text(
          'Follow Our Adventures',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade200,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OptimizedSocialIcon(
              icon: Icons.facebook,
              url:
                  'https://www.facebook.com/profile.php?id=61575163371185&mibextid=wwXIfr&mibextid=wwXIfr',
              color: const Color(0xFF1877F2),
            ),
            const SizedBox(width: 20),
            OptimizedSocialIcon(
              icon: Icons.camera_alt,
              url:
                  'https://www.instagram.com/sharmdesertsafari?igsh=MWIwYXF3MnIzeDdwcg%3D%3D&utm_source=qr',
              color: const Color(0xFFE1306C),
            ),
            const SizedBox(width: 20),
            OptimizedSocialIcon(
              icon: Icons.phone,
              url: 'tel:+201234567890',
              color: const Color(0xFF25D366),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(0.05),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on, color: const Color(0xFF4A90E2), size: 18),
              const SizedBox(width: 8),
              AutoSizeText(
                'Sharm El-Sheikh, South Sinai, Egypt',
                style: TextStyle(color: Colors.grey.shade300, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.email, color: const Color(0xFF4A90E2), size: 18),
              const SizedBox(width: 8),
              AutoSizeText(
                'info@sharmdesertsafari.com',
                style: TextStyle(color: Colors.grey.shade300, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCopyrightSection() {
    return Column(
      children: [
        Text(
          '© 2025 Sharm Desert Safari. All rights reserved.',
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Made with ❤️ for adventure seekers',
          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class OptimizedFooterLink extends StatefulWidget {
  final String text;
  final String url;

  const OptimizedFooterLink({required this.text, required this.url, super.key});

  @override
  State<OptimizedFooterLink> createState() => _OptimizedFooterLinkState();
}

class _OptimizedFooterLinkState extends State<OptimizedFooterLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => _launchUrl(widget.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color:
                _isHovered
                    ? const Color(0xFF4A90E2).withOpacity(0.8)
                    : Colors.transparent,
            border: Border.all(
              color:
                  _isHovered
                      ? Colors.transparent
                      : Colors.white.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Text(
            widget.text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class OptimizedSocialIcon extends StatefulWidget {
  final IconData icon;
  final String url;
  final Color color;

  const OptimizedSocialIcon({
    required this.icon,
    required this.url,
    required this.color,
    super.key,
  });

  @override
  State<OptimizedSocialIcon> createState() => _OptimizedSocialIconState();
}

class _OptimizedSocialIconState extends State<OptimizedSocialIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => _launchUrl(widget.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _isHovered ? widget.color : widget.color.withOpacity(0.7),
            boxShadow:
                _isHovered
                    ? [
                      BoxShadow(
                        color: widget.color.withOpacity(0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                    : null,
          ),
          child: Icon(widget.icon, color: Colors.white, size: 24),
        ),
      ),
    );
  }
}

Future<void> _launchUrl(String url) async {
  final Uri uri = Uri.parse(url);
  try {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  } catch (e) {
    debugPrint('Could not launch $url: $e');
  }
}
