import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:guru_booking/admin/dashboard.dart';
import 'package:guru_booking/utils/networking.dart';
import 'package:guru_booking/utils/tools.dart';
import 'package:image_picker/image_picker.dart';

class TambahKategori extends StatefulWidget {
  const TambahKategori({super.key});
  @override
  State<TambahKategori> createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<TambahKategori> {
  final formKey = GlobalKey<FormState>();
  final namaMapel = TextEditingController();
  final tarif = TextEditingController();
  File? _image;
  final picker = ImagePicker();
  final Dio _dio = Dio();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage(BuildContext context) async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Pilih gambar terlebih dahulu'),
        duration: Duration(seconds: 2),
      ));
      return;
    }

    String fileName = _image!.path;

    FormData formData = FormData.fromMap({
      "deskripsi": namaMapel.text,
      "tarif": int.parse(tarif.text),
      "image": await MultipartFile.fromFile(_image!.path, filename: fileName),
    });

    try {
      Response response = await _dio.post(
        '${Networking().baseUrl}/upload/mapel',
        data: formData,
      );

      if (response.statusCode == 200) {
        if (context.mounted) {
          Tools().NavigateAndClear(context, const DashboardAdmin(index: 2));
        }
      } else {
        debugPrint('Failed to upload image');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah kategori'),leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios,size: 18,color: Colors.white,)),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _image == null
                  ? const Text('Pilih gambar')
                  : Material(
                      borderRadius: BorderRadius.circular(8),
                      elevation: 2,
                      child: Image.file(
                        _image!,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: namaMapel,
                  decoration: const InputDecoration(labelText: 'Deskripsi'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: tarif,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'Tarif', prefixText: 'Rp'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Tarif tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              ),
              InkWell(
                onTap: _pickImage,
                child: styles.coloredText('Buka galeri', Colors.blue),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  if (formKey.currentState?.validate() ?? false) {
                    _uploadImage(
                      context,
                    );
                  }
                },
                child: styles.coloredText('Upload', Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
