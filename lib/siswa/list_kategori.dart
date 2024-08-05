import 'package:flutter/material.dart';
import 'package:guru_booking/siswa/rincian.dart';
import 'package:guru_booking/utils/networking.dart';
import 'package:guru_booking/utils/tools.dart';

class ListKategoriSiswa extends StatefulWidget {
  const ListKategoriSiswa({super.key,required this.deskripsi});
  final String deskripsi;

  @override
  State<ListKategoriSiswa> createState() => _DaftarSiswaState();
}

class _DaftarSiswaState extends State<ListKategoriSiswa> {
  final networking = Networking();
  List<dynamic> data = [];

  void load() async {
    data = await networking.getKategoriSiswa({'mapel':widget.deskripsi});
    if(mounted){

    setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.deskripsi),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 18,
          ),
        ),
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, i) {
            final foto = data[i]['foto_profil'];
            return Padding(
              padding: const EdgeInsets.only(bottom: 1),
              child: Material(
                color: Colors.white,
                elevation: 2,
                child: InkWell(
                  onTap: () {
                    Tools().Navigate(context, Rincian(title: data[i]['nama'],data: data[i],));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        foto != 'default'
                            ? Image.network(data[i]['foto_profil'],height:100,width:120)
                            : Container(
                                decoration: BoxDecoration(border: Border.all()),
                                height: 120,
                                width: 100,
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
                                    Text(data[i]['email']),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 4),
                                      child: Icon(Icons.place),
                                    ),
                                    Text(data[i]['alamat']),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 4),
                                      child: Icon(Icons.phone_android),
                                    ),
                                    Text(data[i]['nohp']),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 4),
                                      child: Icon(Icons.book),
                                    ),
                                    Text(data[i]['mata_pelajaran']),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
