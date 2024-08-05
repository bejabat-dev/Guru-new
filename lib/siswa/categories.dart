import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guru_booking/siswa/list_kategori.dart';
import 'package:guru_booking/utils/networking.dart';
import 'package:guru_booking/utils/tools.dart';

class CategoriesSiswa extends StatefulWidget {
  const CategoriesSiswa({super.key});

  @override
  State<CategoriesSiswa> createState() => _KategoriAdminState();
}

class _KategoriAdminState extends State<CategoriesSiswa> {
  final networking = Networking();
  List<dynamic> data = [];
  void load() async {
    data = await networking.getKategori();
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
                  child: InkWell(onTap: (){
                    utils.Navigate(context, ListKategoriSiswa(deskripsi: data[i]['deskripsi'],));
                  },
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
                                  child: Text(data[i]['deskripsi'],maxLines: 2,overflow: TextOverflow.ellipsis,)),
                                Text('Rp${data[i]['tarif']}'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })
          : const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CupertinoActivityIndicator(), Text('Memuat')],
              ),
            ),
    );
  }
}
