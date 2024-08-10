import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guru_booking/utils/networking.dart';
import 'package:guru_booking/utils/tools.dart';

class DaftarSiswa extends StatefulWidget {
  const DaftarSiswa({super.key});

  @override
  State<DaftarSiswa> createState() => _DaftarSiswaState();
}

class _DaftarSiswaState extends State<DaftarSiswa> {
  final networking = Networking();
  List<dynamic> data = [];

  void load() async {
    data = await networking.getSiswa();
    if (mounted) {
      setState(() {});
    }
  }

  void delete(int id) async {
    Tools().showConfirmDialog(context,  'Hapus siswa ?', 'siswa', id);
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: data.isNotEmpty
          ? ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, i) {
                final foto = data[i]['foto_profil'];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 1),
                  child: Material(
                    color: Colors.white,
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          foto != 'default'
                              ? Image.network(
                                  data[i]['foto_profil'],
                                  width: 80,
                                  height: 120,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  decoration:
                                      BoxDecoration(border: Border.all()),
                                  height: 120,
                                  width: 80,
                                  child: const Center(
                                      child: Text('Tidak ada\nfoto profil'))),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data[i]['nama'],
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(right: 4),
                                        child: Icon(Icons.mail),
                                      ),
                                      Text(
                                          overflow: TextOverflow.ellipsis,
                                          data[i]['email']),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(right: 4),
                                        child: Icon(Icons.place),
                                      ),
                                      Text(
                                          overflow: TextOverflow.ellipsis,
                                          data[i]['alamat']),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(right: 4),
                                        child: Icon(Icons.phone_android),
                                      ),
                                      Text(
                                          overflow: TextOverflow.ellipsis,
                                          data[i]['nohp']),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Material(
                              borderRadius: BorderRadius.circular(8),
                              elevation: 2,
                              color: Colors.red,
                              child: InkWell(
                                onTap: () {
                                  delete(data[i]['id']);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:
                                      style.coloredText('Hapus', Colors.white),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                );
              })
          : const Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [CupertinoActivityIndicator(), Text('Memuat')],
            )),
    );
  }
}
