import 'package:flutter/material.dart';
import 'package:guru_booking/utils/styles.dart';
import 'package:guru_booking/utils/tools.dart';

class Forgot extends StatefulWidget {
  const Forgot({super.key});

  @override
  State<Forgot> createState() => _LoginState();
}

class _LoginState extends State<Forgot> {
  final styles = Styles();
  final formKey = GlobalKey();
  final utils = Tools();

  final email = TextEditingController();

  final emailIcon = const Icon(Icons.email);

  bool validEmail = true;
  bool validPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: styles.customAppBar(context, null),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            styles.authText('Lupa kata sandi'),
            const SizedBox(
              height: 30,
            ),
            Form(
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
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                const SizedBox(
                  height: 20,
                ),Material(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.blue,
                  child: InkWell(
                    onTap: () {},
                    child: SizedBox(
                        height: 45,
                        width: double.infinity,
                        child: Center(child: styles.authButtonText('Kirim kode reset'))),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: styles.linkText('Kembali'),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
