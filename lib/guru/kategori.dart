import 'package:flutter/material.dart';
import 'package:guru_booking/utils/networking.dart';

class KategoriGuru extends StatefulWidget {
  const KategoriGuru({super.key});

  @override
  State<KategoriGuru> createState() => _KategoriGuruState();
}

class _KategoriGuruState extends State<KategoriGuru> {
  final networking = Networking();
  List<dynamic> data = [];
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
    return Scaffold(
      body: GridView.builder(
          itemCount: data.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.65,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4),
          itemBuilder: (context, i) {
            return Material(
                color: Colors.white,
                elevation: 2,
                borderRadius: BorderRadius.circular(8),
                child: Column(
                  children: [
                    Expanded(
                        child: Image.network(
                      data[i]['icon'],
                      fit: BoxFit.cover,
                    )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 60,
                              child: Text(
                                data[i]['deskripsi'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text('Rp${data[i]['tarif']}'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ));
          }),
    );
  }
}