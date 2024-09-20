
import 'package:flutter/material.dart';
import 'package:guru_booking/admin/dashboard.dart';
import 'package:guru_booking/utils/networking.dart';
import 'package:guru_booking/utils/tools.dart';
import 'package:guru_booking/utils/userdata.dart';

class Rincian extends StatefulWidget {
  const Rincian({super.key, required this.title, required this.data});
  final String title;
  final Map<String, dynamic> data;

  @override
  State<Rincian> createState() => _RincianState();
}

class _RincianState extends State<Rincian> {
  List<String> jadwal = [];
  List<dynamic> dataJadwal = [];
  String selectedJadwal = '';
  final formKey = GlobalKey<FormState>();

  int tarif = 0;

  void getTarif() {
    for (var map in Userdata.mapel) {
      if (map['deskripsi'] == widget.data['mata_pelajaran']) {
        setState(() {
          tarif = map['tarif'];
        });
      }
    }
  }

  void load() async {
    dataJadwal = await Networking().getJadwalGuru(widget.data['id']);
    if (dataJadwal.isNotEmpty) {
      for (var map in dataJadwal) {
        jadwal.add(map['tanggal']);
      }
    }
    setState(() {});
  }

  void addBooking() async {
    Map<String, dynamic> data = {
      'id_siswa': Userdata.data['id'],
      'id_guru': widget.data['id'],
      'nama_siswa':Userdata.data['nama'],
      'nama_guru': widget.data['nama'],
      'mata_pelajaran': widget.data['mata_pelajaran'],
      'tarif': tarif,
      'tanggal': selectedJadwal,
      'status': 'Menunggu konfirmasi'
    };
    await Networking().addBooking(context, data);
  }

  @override
  void initState() {
    super.initState();
    load();
    getTarif();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
      body: Padding(
        padding: const EdgeInsets.only(bottom: 1),
        child: Material(
          color: Colors.white,
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                widget.data['foto_profil'] != 'default'
                    ? Image.network(
                        widget.data['foto_profil'],
                        height: 320,
                        width: 250,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        decoration: BoxDecoration(border: Border.all()),
                        height: 320,
                        width: 250,
                        child: const Center(
                            child: Text('Tidak ada\nfoto profil'))),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data['nama'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
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
                          Text(widget.data['email']),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: Icon(Icons.place),
                          ),
                          Text(widget.data['alamat']),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: Icon(Icons.phone_android),
                          ),
                          Text(widget.data['nohp']),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: Icon(Icons.book),
                          ),
                          Text(widget.data['mata_pelajaran']),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: Icon(Icons.calendar_month),
                          ),
                          const Expanded(
                            child: Text('Pilih tanggal'),
                          ),
                          SizedBox(
                            width: 250,
                            child: Form(
                              key: formKey,
                              child: DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                    hintText: 'Jadwal tersedia',
                                    fillColor: Colors.white),
                                items: jadwal.map((String value) {
                                  return DropdownMenuItem(
                                      value: value, child: Text(value));
                                }).toList(),
                                onChanged: (value) {
                                  selectedJadwal = value!;
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return 'Pilih tanggal';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: Icon(Icons.monetization_on),
                          ),
                          const Expanded(child: Text("Tarif")),
                          Text(
                            Tools().formatRupiah(tarif),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Material(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                        child: InkWell(
                          onTap: () {
                            if (formKey.currentState?.validate() ?? false) {
                              addBooking();
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SizedBox(
                                width: double.infinity,
                                child: Center(
                                    child: styles.coloredText(
                                        'Ajukan order', Colors.white))),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
