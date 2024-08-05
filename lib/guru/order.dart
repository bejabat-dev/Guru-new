import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guru_booking/guru/rincian.dart';
import 'package:guru_booking/utils/networking.dart';
import 'package:guru_booking/utils/tools.dart';

class OrderMasuk extends StatefulWidget {
  const OrderMasuk({super.key});

  @override
  State<OrderMasuk> createState() => _HistorySiswaState();
}

class _HistorySiswaState extends State<OrderMasuk> {
  List<dynamic> data = [];
  final networking = Networking();
  void load() async {
    data = await networking.getOrderGuru();
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
      body: data.isNotEmpty
          ? ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 1),
                  child: Material(
                    color: Colors.white,
                    elevation: 1,
                    child: InkWell(
                      onTap: () {
                        Tools().Navigate(context, RincianGuru(data: data[i],));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  data[i]['nama_siswa'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                )),
                                Text(
                                  data[i]['status'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Icon(Icons.calendar_month),
                                const Expanded(child: Text('Tanggal, waktu')),
                                Text(data[i]['tanggal']),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.book),
                                const Expanded(child: Text('Mata pelajaran')),
                                Text(data[i]['mata_pelajaran'].toString()),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.monetization_on),
                                const Expanded(child: Text('Tarif')),
                                Text(Tools().formatRupiah(data[i]['tarif'])),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              })
          : const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('Memuat'), CupertinoActivityIndicator()],
              ),
            ),
    );
  }
}
