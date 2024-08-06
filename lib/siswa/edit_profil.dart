import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guru_booking/siswa/dashboard.dart';
import 'package:guru_booking/utils/networking.dart';
import 'package:guru_booking/utils/tools.dart';
import 'package:guru_booking/utils/userdata.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilSiswa extends StatefulWidget {
  const EditProfilSiswa({super.key});

  @override
  State<EditProfilSiswa> createState() => _EditProfilGuruState();
}

class _EditProfilGuruState extends State<EditProfilSiswa> {
  final formKey = GlobalKey<FormState>();
  String foto = Userdata.data['foto_profil'];

  final nama = TextEditingController();
  final alamat = TextEditingController();
  final nohp = TextEditingController();

  Map<String, dynamic> getMap() {
    Map<String, dynamic> map = {
      'nama': nama.text,
      'alamat': alamat.text,
      'nohp': nohp.text,
      'mata_pelajaran': selectedMapel,
      'email': Userdata.data['email']
    };
    return map;
  }

  String selectedMapel = Userdata.data['mata_pelajaran'];

  void loadMapel() async {
    final data = await Networking().getKategori();
    for (var map in data) {
      mapel.add(map['deskripsi']);
    }
    if (Userdata.data['mata_pelajaran'] == 'Belum disetel') {
      if (mapel.isNotEmpty) {
        selectedMapel = mapel[0];
      }
    }
    setState(() {});
  }

  List<String> mapel = [];

  Widget indicator() {
    if (foto != 'default') {
      return const CupertinoActivityIndicator();
    } else {
      return InkWell(
        onTap: () {
          _pickImage();
        },
        child: const Icon(
          Icons.account_circle,
          size: 85,
        ),
      );
    }
  }

  File? _image;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _uploadImage(context);
      });
    }
  }

  Future<void> _uploadImage(BuildContext context) async {
    if (_image == null) {
      return;
    }

    String fileName = _image!.path;

    FormData formData = FormData.fromMap({
      "deskripsi": Userdata.data['email'],
      "email": Userdata.data['email'],
      "image": await MultipartFile.fromFile(_image!.path, filename: fileName),
    });

    try {
      Response response = await Dio().post(
        '${Networking().baseUrl}/upload/foto',
        data: formData,
      );

      if (response.statusCode == 200) {
        if (context.mounted) {
          await Networking().refreshData(context, Userdata.data['email']);
        }
        setState(() {
          foto = Userdata.data['foto_profil'];
        });
        if (context.mounted) {
          Tools().NavigateAndClear(context, const EditProfilSiswa());
        }
      } else {
        debugPrint('Failed to upload image');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    nama.text = Userdata.data['nama'];
    alamat.text = Userdata.data['alamat'];
    nohp.text = Userdata.data['nohp'];
    loadMapel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit profil'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 18,
          ),
          onPressed: () {
            Tools().NavigateAndClear(context, const DashboardSiswa(index: 3));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              foto != 'default'
                  ? ClipOval(
                      child: InkWell(
                      onTap: () {
                        _pickImage();
                      },
                      child: Image.network(
                        foto,
                        height: 85,
                        width: 85,
                        fit: BoxFit.cover,
                      ),
                    ))
                  : indicator(),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: nama,
                decoration: const InputDecoration(
                    labelText: 'Nama', suffixIcon: Icon(Icons.person)),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: alamat,
                decoration: const InputDecoration(
                    labelText: 'Alamat', suffixIcon: Icon(Icons.place)),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: nohp,
                decoration: const InputDecoration(
                    labelText: 'Nomor HP',
                    suffixIcon: Icon(Icons.phone_android)),
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Networking().updateProfileSiswa(context, getMap());
        },
        child: const Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
    );
  }
}
