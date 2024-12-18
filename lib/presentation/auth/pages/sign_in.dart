import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/common/widgets/botton/basic_app_button.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/data/models/auth/signin_user_req.dart';
import 'package:spotify/domain/usecases/auth/signin_usecase.dart';
import 'package:spotify/presentation/home/pages/home_page.dart';
import 'package:spotify/service_locator.dart';

import 'sign_up.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _signinText(),
            const SizedBox(height: 50),
            _emailField(context),
            const SizedBox(height: 20),
            _passwordField(context),
            const SizedBox(height: 20),
            BasicAppButton(
              onPressed: () async {
                var result = await sl<SigninUseCase>().call(
                  params: SigninUserReq(
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim(),
                  ),
                );

                result.fold(
                  (l) => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        l,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  (r) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                        (route) => false);
                  },
                );
              },
              title: 'Sign In',
            ),
          ],
        ),
      ),
      bottomNavigationBar: _signupText(context),
    );
  }

  Widget _signinText() {
    return const Text(
      'Sign In',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _emailController,
      decoration: const InputDecoration(
        hintText: 'Enter Username or Email',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _passwordController,
      decoration: const InputDecoration(
        hintText: 'Password',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
    );
  }

  Widget _signupText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Not A Member?',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignUpPage(),
                ),
              );
            },
            child: const Text(
              'Register Now',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
