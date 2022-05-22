import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../database/auth_methods.dart';
import '../../utilities/custom_validators.dart';
import '../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../widgets/custom_widgets/custom_textformfield.dart';
import '../../widgets/custom_widgets/password_textformfield.dart';
import '../../widgets/custom_widgets/show_loading.dart';
import '../product_screeen/product_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String routeName = '/LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _key,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 140,
                  width: 140,
                  child: Image.asset('images/logo.png'),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Welcome Back!',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Login your fixly account here',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  controller: _email,
                  hint: 'example@example.com',
                  validator: (String? value) => CustomValidator.email(value),
                  readOnly: _isLoading,
                ),
                PasswordTextFormField(
                  controller: _password,
                  readOnly: _isLoading,
                ),
                _isLoading
                    ? const ShowLoading()
                    : CustomElevatedButton(
                        title: 'Login',
                        onTap: () async {
                          if (_key.currentState!.validate()) {
                            setState(() {
                              _isLoading = true;
                            });
                            final User? user =
                                await AuthMethods().loginWithEmailAndPassword(
                              _email.text.trim(),
                              _password.text.trim(),
                            );
                            if (user == null) {
                              setState(() {
                                _isLoading = false;
                              });
                            } else {
                              if (!mounted) return;
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  ProductScreen.routeName,
                                  (dynamic route) => false);
                            }
                          }
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
