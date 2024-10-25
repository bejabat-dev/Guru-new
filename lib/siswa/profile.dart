import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guru_booking/siswa/edit_profil.dart';
import 'package:guru_booking/utils/networking.dart';
import 'package:guru_booking/utils/tools.dart';
import 'package:guru_booking/utils/userdata.dart';

class ProfileSiswa extends StatefulWidget {
  const ProfileSiswa({super.key});

  @override
  State<ProfileSiswa> createState() => _ProfilGuruState();
}

class _ProfilGuruState extends State<ProfileSiswa> {
  final data = Userdata.data;
  String foto = Userdata.data['foto_profil'];

  Widget indicator() {
    if (foto == 'default') {
      return const Icon(
        Icons.account_circle,
        size: 85,
      );
    } else {
      return const CupertinoActivityIndicator();
    }
  }

  @override
  Widget build(BuildContext context) {
    final utils = Tools();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            foto != 'default'
                ? ClipOval(
                    child: Image.network(
                    Userdata.data['foto_profil'],
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ))
                : indicator(),
            Text(
              data['nama'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              data['email'],
            ),
            const SizedBox(
              height: 15,
            ),
            const SizedBox(
                width: double.infinity,
                child: Text(
                  'Informasi akun',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 1),
              child: Material(
                color: Colors.white,
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 5.0),
                        child: Icon(Icons.place),
                      ),
                      const Expanded(child: Text('Alamat')),
                      Text(data['alamat'])
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 1),
              child: Material(
                color: Colors.white,
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 5.0),
                        child: Icon(Icons.phone_android),
                      ),
                      const Expanded(child: Text('Nomor HP')),
                      Text(data['nohp'])
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 1),
              child: Material(
                color: Colors.white,
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 5.0),
                        child: Icon(Icons.person),
                      ),
                      const Expanded(child: Text('Terdaftar sebagai')),
                      Text(data['role'])
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 1),
              child: Material(
                color: Colors.white,
                elevation: 1,
                child: InkWell(
                  onTap: () {
                    utils.Navigate(context, const EditProfilSiswa());
                  },
                  child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 5.0),
                            child: Icon(Icons.edit),
                          ),
                          Text('Edit profil'),
                        ],
                      )),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 1),
              child: Material(
                color: Colors.white,
                elevation: 1,
                child: InkWell(
                  onTap: () {
                    Networking().logout(context);
                  },
                  child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 5.0),
                            child: Icon(Icons.logout),
                          ),
                          Text('Keluar'),
                        ],
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
