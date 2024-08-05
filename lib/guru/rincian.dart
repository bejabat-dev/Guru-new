import 'package:flutter/material.dart';
import 'package:guru_booking/utils/networking.dart';
import 'package:guru_booking/utils/tools.dart';

class RincianGuru extends StatefulWidget {
  const RincianGuru({super.key, required this.data});
  final Map<String, dynamic> data;

  @override
  State<RincianGuru> createState() => _RincianGuruState();
}

class _RincianGuruState extends State<RincianGuru> {
  void updateOrder() async {
    await networking.updateOrder(
        context, {'id': widget.data['id'], 'stat': 'Sedang berjalan'});
  }

  final networking = Networking();
  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rincian'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all()),
              height: 320,
              width: 250,
              child: Center(
                child: Text('Tidak ada foto'),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                data['nama_siswa'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.book),
                        Text('Mata pelajaran'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.calendar_month),
                        Text('Tanggal'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.monetization_on),
                        Text('Tarif'),
                      ],
                    ),
                  ],
                )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(data['mata_pelajaran']),
                    Text(data['tanggal']),
                    Text(Tools().formatRupiah(data['tarif'])),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Material(
              borderRadius: BorderRadius.circular(8),
              color: Colors.blue,
              child: InkWell(
                onTap: () {
                  updateOrder();
                },
                child: const SizedBox(
                    width: double.infinity,
                    child: Center(
                        child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Terima order',
                        style: TextStyle(color: Colors.white),
                      ),
                    ))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
