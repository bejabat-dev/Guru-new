import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guru_booking/utils/networking.dart';
import 'package:guru_booking/utils/styles.dart';
import 'package:intl/intl.dart';

final style = Styles();

class Tools {
  bool isValidEmail(String email) {
    bool B;
    final emailRegExp = RegExp(r'^[\w-\.]+@[a-zA-Z\d\.-]+\.[a-zA-Z]{2,}$');
    if (email == 'admin' || emailRegExp.hasMatch(email)) {
      B = true;
    } else {
      B = false;
    }

    return B;
  }

  bool isValidPassword(String password) {
    bool b;
    if (password.length < 7) {
      b = false;
    } else {
      b = true;
    }
    return b;
  }

  void showError(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Konfirmasi'),
          ),
        ],
      ),
    );
  }

  void Navigate(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (route) => widget));
  }

  void NavigateAndClear(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (route) => widget), (route) => false);
  }

  void NavigateReplace(BuildContext context, Widget widget) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => widget));
  }

  void showCustomDialog(BuildContext context, String text) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SizedBox(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CupertinoActivityIndicator(),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(text),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          return;
                        },
                        child: style.linkText('Batal')),
                  )
                ],
              ),
            ),
          );
        });
  }

  void showErrorDialog(BuildContext context, String text) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SizedBox(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(text),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          return;
                        },
                        child: style.linkText('Konfirmasi')),
                  )
                ],
              ),
            ),
          );
        });
  }

  void showLoadingDialog(BuildContext context, String text) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SizedBox(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(text),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          return;
                        },
                        child: style.linkText('Batal')),
                  )
                ],
              ),
            ),
          );
        });
  }

  String formatRupiah(int amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  void showConfirmDialog(
      BuildContext context, String judul, String jenis, int id) {
    showDialog(
        context: (context),
        builder: (context) {
          return AlertDialog(
            content: Text(judul),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Batal')),
              TextButton(
                  onPressed: () async {
                    if (jenis == 'siswa') {
                      Networking().deleteSiswa(context, {'id': id});
                    } else if (jenis == 'guru') {
                      await Networking().deleteGuru(context, {'id': id});
                    }
                  },
                  child: const Text(
                    'Hapus',
                    style: TextStyle(color: Colors.red),
                  ))
            ],
          );
        });
  }
}
