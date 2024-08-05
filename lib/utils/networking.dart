import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:guru_booking/admin/dashboard.dart';
import 'package:guru_booking/auth/login.dart';
import 'package:guru_booking/guru/atur_jadwal.dart';
import 'package:guru_booking/guru/dashboard.dart';
import 'package:guru_booking/siswa/dashboard.dart';
import 'package:guru_booking/utils/tools.dart';
import 'package:guru_booking/utils/userdata.dart';

class Networking {
  final dio = Dio();
  final utils = Tools();

  final baseUrl = 'https://thorn-horn-sandalwood.glitch.me/guruku';

  Future<void> checkLogin(BuildContext context) async {
    if (Userdata.prefs!.getBool('loggedin') == true) {
      getUserData(context, Userdata.prefs!.getString('email')!);
    }
  }

  Future<void> register(BuildContext context, String nama, String email,
      String password, String role) async {
    utils.showCustomDialog(context, 'Mendaftarkan akun');
    try {
      final res = await dio.post('$baseUrl/register', data: {
        'nama': nama,
        'email': email,
        'password': password,
        'role': role,
      });
      if (res.statusCode == 201) {
        if (context.mounted) {
          Navigator.pop(context);
          getUserData(context, email);
        }
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        if (e.toString().contains('501')) {
          utils.showErrorDialog(context, 'Email sudah digunakan');
        } else {
          utils.showErrorDialog(
              context, 'Terjadi kesalahan, periksa koneksi internet');
        }
      }
    }
  }

  Future<void> login(
      BuildContext context, String email, String password) async {
    utils.showCustomDialog(context, 'Sedang masuk');
    try {
      final res = await dio
          .post('$baseUrl/login', data: {'email': email, 'password': password});
      if (res.statusCode == 200) {
        if (context.mounted) {
          getUserData(context, email);
        }
      }
    } catch (e) {
      if (e.toString().contains('404')) {
        if (context.mounted) {
          Navigator.pop(context);
          utils.showErrorDialog(
            context,
            'Email tidak ditemukan',
          );
        }
      } else if (e.toString().contains('401')) {
        if (context.mounted) {
          Navigator.pop(context);
          utils.showErrorDialog(
            context,
            'Kata sandi salah',
          );
        }
      } else {
        if (context.mounted) {
          Navigator.pop(context);
          utils.showErrorDialog(
            context,
            'Periksa jaringan anda',
          );
        }
      }
    }
  }

  Future<void> refreshData(BuildContext context, String email) async {
    try {
      final res = await dio.get('$baseUrl/user', data: {'email': email});
      if (res.statusCode == 200) {
        Userdata.data = res.data;
      }
    } catch (e) {}
  }

  Future<String?> getToken(String documentId) async {
    try {
      DocumentReference documentRef =
          FirebaseFirestore.instance.collection('tokens').doc(documentId);
      DocumentSnapshot documentSnapshot = await documentRef.get();

      if (documentSnapshot.exists) {
        Map<String, dynamic>? data =
            documentSnapshot.data() as Map<String, dynamic>?;
        return data?['token'] as String?;
      } else {
        debugPrint('Document does not exist');
        return null;
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
      return null;
    }
  }

  Future<void> getUserData(BuildContext context, String email) async {
    final fcm = FirebaseMessaging.instance;
    final db = FirebaseFirestore.instance.collection('tokens');
    try {
      final res = await dio.get('$baseUrl/user', data: {'email': email});
      if (res.statusCode == 200) {
        String token = await fcm.getToken() as String;
        await db.doc(email).set({'token': token}).catchError((e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Terjadi kesalahan'),
            duration: Duration(seconds: 2),
          ));
          return;
        });
        Userdata.data = res.data;
        Userdata.prefs!.setString('email', email);
        Userdata.prefs!.setBool('loggedin', true);
        if (res.data['role'] == 'Siswa') {
          if (context.mounted) {
            utils.NavigateAndClear(
                context,
                const DashboardSiswa(
                  index: 0,
                ));
          }
        } else if (res.data['role'] == 'Admin') {
          if (context.mounted) {
            utils.NavigateAndClear(
                context,
                const DashboardAdmin(
                  index: 0,
                ));
          }
        } else if (res.data['role'] == 'Guru') {
          if (context.mounted) {
            utils.NavigateAndClear(
                context,
                const DashboardGuru(
                  index: 0,
                ));
          }
        }
      }
    } catch (e) {
      if (context.mounted) {
        utils.showErrorDialog(
          context,
          'Terjadi kesalahan',
        );
      }
    }
  }

  Future<Map<String, dynamic>> getUserByid(int id) async {
    try {
      final res = await dio.get('$baseUrl/user/id', data: {'id': id});
      if (res.statusCode == 200) {
        return res.data;
      }
    } catch (e) {
      return {};
    }
    return {};
  }

  Future<List<dynamic>> getKategori() async {
    final res = await dio.get('$baseUrl/kategori');
    debugPrint(res.data.toString());
    return res.data;
  }

  Future<List<dynamic>> getKategoriSiswa(dynamic data) async {
    final res = await dio.get('$baseUrl/list_kategori', data: data);
    debugPrint(res.data.toString());
    return res.data;
  }

  Future<List<dynamic>> getSiswa() async {
    final res = await dio.get('$baseUrl/user/siswa');
    debugPrint(res.data.toString());
    return res.data;
  }

  Future<List<dynamic>> getGuru() async {
    final res = await dio.get('$baseUrl/user/guru');
    debugPrint(res.data.toString());
    return res.data;
  }

  Future<List<dynamic>> getJadwal() async {
    final res =
        await dio.get('$baseUrl/jadwal', data: {'id': Userdata.data['id']});
    debugPrint(res.data.toString());
    return res.data;
  }

  Future<List<dynamic>> getOrder() async {
    final res = await dio
        .get('$baseUrl/order', data: {'id_siswa': Userdata.data['id']});
    if (res.statusCode == 200) {
      debugPrint(res.data.toString());
      return res.data;
    } else {
      debugPrint(res.data.toString());
      return [];
    }
  }

  Future<List<dynamic>> getOrderGuru() async {
    final res =
        await dio.get('$baseUrl/order/guru', data: {'id': Userdata.data['id']});
    if (res.statusCode == 200) {
      debugPrint(res.data.toString());
      return res.data;
    } else {
      debugPrint(res.data.toString());
      return [];
    }
  }

  Future<List<dynamic>> getRiwayatGuru() async {
    final res = await dio
        .get('$baseUrl/riwayat/guru', data: {'id': Userdata.data['id']});
    if (res.statusCode == 200) {
      debugPrint(res.data.toString());
      return res.data;
    } else {
      debugPrint(res.data.toString());
      return [];
    }
  }

  Future<void> updateOrder(BuildContext context, dynamic data) async {
    final res = await dio.post('$baseUrl/update/order', data: data);
    if (res.statusCode == 200) {
      utils.NavigateAndClear(context, DashboardGuru(index: 0));
    }
  }

  Future<List<dynamic>> getJadwalGuru(int id) async {
    final res = await dio.get('$baseUrl/jadwal', data: {'id': id});
    debugPrint(res.data.toString());
    return res.data;
  }

  Future<void> addJadwal(BuildContext context, dynamic data) async {
    final res = await dio.post('$baseUrl/jadwal', data: data);
    if (res.statusCode == 200) {
      if (context.mounted) {
        utils.NavigateReplace(context, const AturJadwal());
      }
    }
  }

  Future<void> addBooking(BuildContext context, dynamic data) async {
    utils.showLoadingDialog(context, 'Memuat');
    final res = await dio.post('$baseUrl/order', data: data);
    if (res.statusCode == 200) {
      if (context.mounted) {
        Navigator.pop(context);
        utils.NavigateAndClear(
            context,
            const DashboardSiswa(
              index: 0,
            ));
      }
    } else {
      if (context.mounted) {
        Navigator.pop(context);
        utils.showErrorDialog(context, 'Periksa koneksi internet');
      }
    }
  }

  Future<void> deleteJadwal(BuildContext context, dynamic data) async {
    final res = await dio.delete('$baseUrl/jadwal', data: data);
    if (res.statusCode == 200) {
      if (context.mounted) {
        Navigator.pop(context);
        utils.NavigateReplace(context, const AturJadwal());
      }
    }
  }

  Future<void> updateProfileGuru(
      BuildContext context, Map<String, dynamic> data) async {
    final res = await dio.post('$baseUrl/user/updateguru', data: data);
    if (res.statusCode == 200) {
      if (context.mounted) {
        await refreshData(context, Userdata.data['email']);
        utils.NavigateAndClear(
            context,
            const DashboardGuru(
              index: 3,
            ));
      }
    }
  }

  Future<void> updateProfileSiswa(
      BuildContext context, Map<String, dynamic> data) async {
    final res = await dio.post('$baseUrl/user/updateguru', data: data);
    if (res.statusCode == 200) {
      if (context.mounted) {
        await refreshData(context, Userdata.data['email']);
        utils.NavigateAndClear(
            context,
            const DashboardSiswa(
              index: 3,
            ));
      }
    }
  }

  Future<void> deleteMapel(
      BuildContext context, Map<String, dynamic> data) async {
    final res = await dio.post('$baseUrl/mapel/delete', data: data);
    if (res.statusCode == 200) {
      if (context.mounted) {
        utils.NavigateAndClear(
            context,
            const DashboardAdmin(
              index: 2,
            ));
      }
    }
  }

  void logout(BuildContext context) {
    Userdata.prefs!.setBool('loggedin', false);
    utils.NavigateAndClear(context, const Login());
  }
}
