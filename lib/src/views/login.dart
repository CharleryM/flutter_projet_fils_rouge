import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9EEE8),
      body: Center(
        child: Container(
          width: 420,
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: const Color(0xFF0D1723),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: 30,
                offset: const Offset(0, 16),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _TopBar(),
                  const SizedBox(height: 20),
                  _LogoPanel(),
                  const SizedBox(height: 22),
                  const Text(
                    'QS SYSTÈME • V2.4 ONLINE',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF7CE3FF),
                      fontSize: 11,
                      letterSpacing: 1.4,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'CONNEXION',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 38,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1.1,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Retrouvez toutes sauvegardes, la télémetrie\nFPS temps réel et des alertes stock.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFB8C1CF),
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 18),
                  _SocialButton(
                    label: 'Continuer avec Google',
                    icon: const Text(
                      'G',
                      style: TextStyle(
                        color: Color(0xFF1C1C1C),
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    backgroundColor: const Color(0xFF2C2F35),
                    foregroundColor: Colors.white,
                    iconBackground: const Color(0xFFF3F4F6),
                  ),
                  const SizedBox(height: 10),
                  _SocialButton(
                    label: 'Continuer avec Apple',
                    icon: const Icon(Icons.apple, color: Colors.white, size: 24),
                    backgroundColor: const Color(0xFF2C2F35),
                    foregroundColor: Colors.white,
                    iconBackground: const Color(0xFF1A1A1A),
                  ),
                  const SizedBox(height: 10),
                  _SocialButton(
                    label: 'Continuer avec Facebook',
                    icon: const Icon(Icons.facebook, color: Colors.white, size: 22),
                    backgroundColor: const Color(0xFF2C2F35),
                    foregroundColor: Colors.white,
                    iconBackground: const Color(0xFF1877F2),
                  ),
                  const SizedBox(height: 18),
                  _InviteRow(),
                  const SizedBox(height: 12),
                  const _StatsRow(),
                  const SizedBox(height: 16),
                  const Text(
                    'Pas encore de compte ? S’inscrire gratuitement',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFB9C7D8),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Sécurisé par RigFinder • Chiffrement SSL 256-bit',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF7B8AA0),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
          style: IconButton.styleFrom(
            backgroundColor: const Color(0xFF111C2A),
            minimumSize: const Size(34, 34),
            padding: EdgeInsets.zero,
          ),
        ),
        const Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.link, color: Color(0xFF7CE3FF), size: 16),
                SizedBox(width: 8),
                Text(
                  'RigFinder',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFFB0C3D9),
            padding: const EdgeInsets.symmetric(horizontal: 8),
          ),
          child: const Text(
            'LOGIN',
            style: TextStyle(
              fontSize: 11,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 4),
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: const Color(0xFF1C2735),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(Icons.person, color: Colors.white, size: 16),
        ),
      ],
    );
  }
}

class _LogoPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 86,
        height: 86,
        decoration: BoxDecoration(
          color: const Color(0xFF1A2938),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF35495F), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF7CE3FF).withValues(alpha: 0.12),
              blurRadius: 24,
            ),
          ],
        ),
        child: const Center(
          child: Icon(
            Icons.sensors_rounded,
            color: Color(0xFF8CEBFF),
            size: 34,
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String label;
  final Widget icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color iconBackground;

  const _SocialButton({
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.iconBackground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: iconBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(child: icon),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: foregroundColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.white),
          ],
        ),
      ),
    );
  }
}

class _InviteRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2938),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: const Color(0xFF0D1723),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.person_outline, size: 16, color: Colors.white),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'Mode Invité',
              style: TextStyle(
                color: Color(0xFFE7ECF5),
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          const Text(
            'EXPLORER',
            style: TextStyle(
              color: Color(0xFF7CE3FF),
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    final stats = [
      ('BUILDS VÉRIFIÉS', '14,820+'),
      ('COMPATIBILITÉ', '99.9%'),
      ('LATENCE SYSTÈME', '1.2 ms'),
    ];

    return Row(
      children: List.generate(stats.length, (index) {
        final item = stats[index];
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: index < stats.length - 1 ? 8 : 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.$1,
                  style: const TextStyle(
                    color: Color(0xFF8EA0B5),
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.$2,
                  style: const TextStyle(
                    color: Color(0xFF7CE3FF),
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}