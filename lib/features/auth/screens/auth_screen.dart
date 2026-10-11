import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/firebase/firebase_support.dart';
import '../../../theme/theme_exports.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLogin = true;
  bool _isBusy = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isBusy = true;
      _errorMessage = null;
    });

    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text;

      if (_isLogin) {
        await FirebaseSupport.auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        await FirebaseSupport.analytics.logLogin(loginMethod: 'password');
      } else {
        await FirebaseSupport.auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await FirebaseSupport.analytics.logSignUp(signUpMethod: 'password');
      }
    } on FirebaseAuthException catch (error) {
      if (!mounted) return;
      setState(() => _errorMessage = _messageFor(error.code));
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
  }

  Future<void> _sendPasswordReset() async {
    final email = _emailController.text.trim();
    if (!email.contains('@')) {
      setState(() => _errorMessage = 'Прво внеси валиден email.');
      return;
    }

    try {
      await FirebaseSupport.auth.sendPasswordResetEmail(email: email);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Провери го email-от за reset линк.')),
      );
    } on FirebaseAuthException catch (error) {
      if (!mounted) return;
      setState(() => _errorMessage = _messageFor(error.code));
    }
  }

  Future<void> _continueAsGuest() async {
    setState(() {
      _isBusy = true;
      _errorMessage = null;
    });

    try {
      await FirebaseSupport.auth.signInAnonymously();
      await FirebaseSupport.analytics.logLogin(loginMethod: 'anonymous');
    } on FirebaseAuthException catch (error) {
      if (!mounted) return;
      setState(() => _errorMessage = _messageFor(error.code));
    } catch (_) {
      if (!mounted) return;
      setState(() => _errorMessage = 'Не успеавме да продолжиме како гостин.');
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isBusy = true;
      _errorMessage = null;
    });

    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return;
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseSupport.auth.signInWithCredential(
        credential,
      );
      await _logSocialAuth(userCredential, 'google');
    } on FirebaseAuthException catch (error) {
      if (!mounted) return;
      setState(() => _errorMessage = _messageFor(error.code));
    } catch (error) {
      if (!mounted) return;
      setState(() => _errorMessage = 'Google login беше откажан или не успеа.');
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
  }

  Future<void> _signInWithFacebook() async {
    setState(() {
      _isBusy = true;
      _errorMessage = null;
    });

    try {
      final loginResult = await FacebookAuth.instance.login();
      if (loginResult.status == LoginStatus.cancelled ||
          loginResult.accessToken == null) {
        return;
      }

      final credential = FacebookAuthProvider.credential(
        loginResult.accessToken!.tokenString,
      );

      final userCredential = await FirebaseSupport.auth.signInWithCredential(
        credential,
      );
      await _logSocialAuth(userCredential, 'facebook');
    } on FirebaseAuthException catch (error) {
      if (!mounted) return;
      setState(() => _errorMessage = _messageFor(error.code));
    } catch (error) {
      if (!mounted) return;
      setState(
        () => _errorMessage = 'Facebook login не успеа. Обиди се повторно.',
      );
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
  }

  Future<void> _logSocialAuth(
    UserCredential userCredential,
    String method,
  ) async {
    final isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;

    if (isNewUser) {
      await FirebaseSupport.analytics.logSignUp(signUpMethod: method);
    } else {
      await FirebaseSupport.analytics.logLogin(loginMethod: method);
    }
  }

  String _messageFor(String code) {
    switch (code) {
      case 'invalid-credential':
      case 'wrong-password':
      case 'user-not-found':
        return 'Погрешен email или лозинка.';
      case 'email-already-in-use':
        return 'Овој email веќе има account.';
      case 'weak-password':
        return 'Лозинката треба да има најмалку 6 знаци.';
      case 'invalid-email':
        return 'Внеси валидна email адреса.';
      case 'network-request-failed':
        return 'Провери ја интернет-врската и обиди се повторно.';
      default:
        return 'Не успеавме да го завршиме барањето. Обиди се повторно.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(Icons.spa_outlined, size: 72),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      'Добредојде во Motiva',
                      textAlign: TextAlign.center,
                      style: MotivaTypography.h1,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      _isLogin
                          ? 'Најави се за да продолжиш.'
                          : 'Креирај account за да продолжиш.',
                      textAlign: TextAlign.center,
                      style: MotivaTypography.body.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      validator: (value) {
                        if (value == null || !value.contains('@')) {
                          return 'Внеси валиден email.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      autofillHints: const [AutofillHints.password],
                      decoration: const InputDecoration(
                        labelText: 'Лозинка',
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return 'Лозинката треба да има најмалку 6 знаци.';
                        }
                        return null;
                      },
                    ),
                    if (_errorMessage != null) ...[
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        _errorMessage!,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.danger),
                      ),
                    ],
                    const SizedBox(height: AppSpacing.lg),
                    FilledButton(
                      onPressed: _isBusy ? null : _submit,
                      child: Text(
                        _isBusy
                            ? 'Се обработува...'
                            : (_isLogin ? 'Најави се' : 'Креирај account'),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    OutlinedButton.icon(
                      onPressed: _isBusy ? null : _continueAsGuest,
                      icon: const Icon(Icons.person_outline_rounded),
                      label: const Text('Продолжи без најавување'),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    OutlinedButton.icon(
                      onPressed: _isBusy ? null : _signInWithGoogle,
                      icon: const Icon(Icons.g_mobiledata_rounded),
                      label: const Text('Продолжи со Google'),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    OutlinedButton.icon(
                      onPressed: _isBusy ? null : _signInWithFacebook,
                      icon: const Icon(Icons.facebook_rounded),
                      label: const Text('Продолжи со Facebook'),
                    ),
                    if (_isLogin)
                      TextButton(
                        onPressed: _isBusy ? null : _sendPasswordReset,
                        child: const Text('Ја заборави лозинката?'),
                      ),
                    TextButton(
                      onPressed: _isBusy
                          ? null
                          : () => setState(() {
                              _isLogin = !_isLogin;
                              _errorMessage = null;
                            }),
                      child: Text(
                        _isLogin
                            ? 'Немаш account? Креирај account'
                            : 'Веќе имаш account? Најави се',
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'Со продолжување прифаќаш дека Motiva е wellness апликација, а не медицинска или кризна служба.',
                      textAlign: TextAlign.center,
                      style: MotivaTypography.caption.copyWith(
                        color: AppColors.textMuted,
                      ),
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
