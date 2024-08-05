import 'package:flutter/material.dart';
import 'package:guru_booking/utils/networking.dart';
import 'package:guru_booking/utils/styles.dart';
import 'package:guru_booking/utils/tools.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _LoginState();
}

class _LoginState extends State<Register> {
  final styles = Styles();
  final formKey = GlobalKey();
  final utils = Tools();

  final email = TextEditingController();
  final password = TextEditingController();
  final repassword = TextEditingController();
  final nama = TextEditingController();

  final emailIcon = const Icon(Icons.email);
  final passwordIcon = const Icon(Icons.password);

  List<String> roles = ['Siswa', 'Guru'];
  String selectedRole = 'Siswa';

  bool validEmail = true;
  bool validPassword = true;
  bool samePassword = true;
  void register() {
    utils.showCustomDialog(context, 'Mendaftarkan akun');
  }

  final networking = Networking();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: styles.customAppBar(context, null),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            styles.authText('Buat akun baru'),
            const SizedBox(
              height: 30,
            ),
            Form(
                child: Column(
              children: [
                TextFormField(
                  controller: nama,
                  decoration: styles.normalInput(
                      'Nama lengkap', const Icon(Icons.person)),
                ),
                const SizedBox(
                  height: 8,
                ),
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
                DropdownButtonFormField<String>(
                    iconEnabledColor: Colors.white,
                    value: selectedRole,
                    decoration: styles.dropDownInput('Daftar sebagai', null),
                    selectedItemBuilder: (context) {
                      return roles.map<Widget>((String value) {
                        return styles.coloredText(value, Colors.white);
                      }).toList();
                    },
                    items: roles.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem(value: value, child: Text(value));
                    }).toList(),
                    onChanged: (value) {
                      selectedRole = value!;
                    }),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  obscureText: true,
                  enableSuggestions: false,
                  controller: password,
                  decoration: validPassword == true
                      ? styles.normalInput('Kata sandi', passwordIcon)
                      : styles.errorInput(
                          'Kata sandi harus melebihi 6 karakter', passwordIcon),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        validPassword = utils.isValidPassword(value);
                      });
                    }
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  obscureText: true,
                  enableSuggestions: false,
                  controller: repassword,
                  decoration: samePassword == true
                      ? styles.normalInput('Ulangi kata sandi', passwordIcon)
                      : styles.errorInput(
                          'Kata sandi tidak sama', passwordIcon),
                  onChanged: (value) {
                    if (value != password.text) {
                      setState(() {
                        samePassword = false;
                      });
                    } else {
                      setState(() {
                        samePassword = true;
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
                      networking.register(context, nama.text, email.text,
                          password.text, selectedRole);
                    },
                    child: SizedBox(
                        height: 45,
                        width: double.infinity,
                        child: Center(child: styles.authButtonText('Daftar'))),
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