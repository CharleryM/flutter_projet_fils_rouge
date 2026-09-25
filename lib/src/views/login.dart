import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iconoir_flutter/solid/google_circle.dart';
import 'game_selection.dart';
import '../widgets/login_header.dart';
import '../widgets/social_login_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _errorMessage;

  Future<void> _signInWithGoogle() async {
    setState(() => _errorMessage = null);

    try {
      final googleUser = await GoogleSignIn.instance.authenticate();
      final googleAuth = googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      if (mounted) {
        await Navigator.of(context).pushReplacement(
          MaterialPageRoute<void>(
            builder: (_) => const GameSelectionPage(),
          ),
        );
      }
    } on GoogleSignInException catch (error) {
      if (mounted) {
        setState(() => _errorMessage = 'Connexion Google impossible : ${error.description ?? error.code.name}.');
      }
    } on FirebaseAuthException catch (error) {
      if (mounted) {
        setState(() => _errorMessage = 'Connexion Firebase impossible : ${error.message ?? error.code}.');
      }
    } on Exception catch (error) {
      if (mounted) {
        setState(() => _errorMessage = 'Connexion impossible : $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1723),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const LoginHeader(),
                    const SizedBox(height: 28),
                    const Text(
                      'Connexion',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Connectez-vous à votre espace RigFinder.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFB8C1CF),
                        fontSize: 13,
                        height: 1.45,
                      ),
                    ),

                    const SizedBox(height: 24),
                    SocialLoginButton(
                      label: 'Continuer avec Google',
                      icon: const GoogleCircleSolid(
                        width: 22,
                        height: 22,
                        color: Color(0xFF7CE3FF),
                      ),
                      onPressed: _signInWithGoogle,
                    ),

                    if (_errorMessage != null) ...[
                      const SizedBox(height: 14),
                      Text(
                        _errorMessage!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Color(0xFFFF8D8D), fontSize: 12),
                      ),
                    ],

                    const SizedBox(height: 14),
                    SocialLoginButton(
                      label: 'Continuer avec Apple',
                      icon: const Icon(
                        Icons.apple,
                        color: Color(0xFF7CE3FF),
                        size: 22,
                      ),
                      onPressed: () async {
                        setState(() => _errorMessage = 'La connexion Apple sera ajoutée après la configuration Apple Sign-In.');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
