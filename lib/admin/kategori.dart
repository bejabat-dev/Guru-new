import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guru_booking/admin/tambah_kategori.dart';
import 'package:guru_booking/utils/networking.dart';
import 'package:guru_booking/utils/tools.dart';

class KategoriAdmin extends StatefulWidget {
  const KategoriAdmin({super.key});

  @override
  State<KategoriAdmin> createState() => _KategoriAdminState();
}

class _KategoriAdminState extends State<KategoriAdmin> {
  final networking = Networking();
  List<dynamic> data = [];

  void showDelete(int id ,String mapel) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Hapus $mapel ?'),actions: [
              TextButton(onPressed: (){Navigator.pop(context);}, child: const Text('Batal')),
              TextButton(onPressed: (){
                Navigator.pop(context);
                networking.deleteMapel(context, {'id':id});}, child: const Text('Hapus'))
            ],
          );
        });
  }

  void load() async {
    data = await networking.getKategori();
    if (mounted) {
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
    final utils = Tools();
    return Scaffold(
      body: data.isNotEmpty
          ? GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.65,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4),
              itemCount: data.length,
              itemBuilder: (context, i) {
                return Material(
                  elevation: 2,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  child: Column(
                    children: [
                      Expanded(
                          child: Image.network(
                        data[i]['icon'],
                        fit: BoxFit.cover,
                      )),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  height: 60,
                                  child: Text(
                                    data[i]['deskripsi'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                              Row(
                                children: [
                                  Expanded(
                                      child: Text('Rp${data[i]['tarif']}')),
                                  InkWell(
                                      onTap: () {showDelete(data[i]['id'],data[i]['deskripsi']);},
                                      child: const Icon(
                                        Icons.delete,
                                        color: Color.fromARGB(255, 231, 41, 27),
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              })
          : const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CupertinoActivityIndicator(), Text('Memuat')],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          utils.Navigate(context, const TambahKategori());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
