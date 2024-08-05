import 'package:flutter/material.dart';
import 'package:guru_booking/auth/forgot.dart';
import 'package:guru_booking/auth/register.dart';
import 'package:guru_booking/utils/networking.dart';
import 'package:guru_booking/utils/styles.dart';
import 'package:guru_booking/utils/tools.dart';
import 'package:guru_booking/utils/userdata.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final styles = Styles();
  final networking = Networking();
  final formKey = GlobalKey<FormState>();
  final utils = Tools();

  final email = TextEditingController();
  final password = TextEditingController();

  final emailIcon = const Icon(Icons.email);
  final passwordIcon = const Icon(Icons.password);

  bool validEmail = true;
  bool validPassword = true;

  void loadUser() async {
    await Userdata.getPrefs();
    if (mounted) {
      networking.checkLogin(context);
    }
  }

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            styles.authText('Masuk untuk melanjutkan'),
            const SizedBox(
              height: 30,
            ),
            Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                        controller: email,
                        decoration: validEmail == true
                            ? styles.normalInput('Email', emailIcon)
                            : styles.errorInput('Email tidak valid', emailIcon),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              validEmail = utils.isValidEmail(value);
                            });
                          }
                        }),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                  obscureText: true,
                      controller: password,
                      decoration: validPassword == true
                          ? styles.normalInput('Kata sandi', passwordIcon)
                          : styles.errorInput(
                              'Kata sandi harus melebihi 6 karakter',
                              passwordIcon),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            validPassword = utils.isValidPassword(value);
                          });
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.blue,
                      child: InkWell(
                        onTap: () {
                          if (email.text == 'admin' &&
                              password.text == 'admin') {
                            networking.login(
                                context, email.text, password.text);
                          } else {
                            if (validEmail &&
                                validPassword &&
                                email.text.isNotEmpty &&
                                password.text.isNotEmpty) {
                              networking.login(
                                  context, email.text, password.text);
                            }
                          }
                        },
                        child: SizedBox(
                            height: 45,
                            width: double.infinity,
                            child:
                                Center(child: styles.authButtonText('Masuk'))),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            utils.Navigate(context, const Register());
                          },
                          child: styles.linkText('Buat akun'),
                        ),
                        const Text(' atau '),
                        InkWell(
                          onTap: () {
                            utils.Navigate(context, const Forgot());
                          },
                          child: styles.linkText('Lupa kata sandi'),
                        )
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
