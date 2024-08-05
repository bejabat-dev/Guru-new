import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guru_booking/utils/networking.dart';
import 'package:guru_booking/utils/tools.dart';
import 'package:guru_booking/utils/userdata.dart';
import 'package:intl/intl.dart';

class AturJadwal extends StatefulWidget {
  const AturJadwal({super.key});

  @override
  State<AturJadwal> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<AturJadwal> {
  DateTime? _selectedDateTime;
  final networking = Networking();
  final utils = Tools();

  String formatDate(DateTime dateTime) {
    return DateFormat('HH:mm dd/MM/yyyy').format(dateTime); // 24-hour format
  }

  Future<void> _selectDateTime(BuildContext context) async {
    DateTime now = DateTime.now();

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(2101),
    );

    if (context.mounted && pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        },
      );

      if (context.mounted && pickedTime != null) {
        DateTime selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        if (selectedDateTime.isBefore(now)) {
          utils.showError(context, 'Waktu tidak valid');
        } else {
          setState(() {
            _selectedDateTime = selectedDateTime;
          });
          await networking.addJadwal(context, {
            'id': Userdata.data['id'],
            'tanggal': formatDate(_selectedDateTime!)
          });
        }
      }
    }
  }

  void showDeleteDialog(int id) {
    showDialog(
        context: context,
        builder: (conetxt) {
          return AlertDialog(
            content: const Text('Hapus jadwal ?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Batal')),
              TextButton(
                  onPressed: () {
                    networking.deleteJadwal(context, {'id': id});
                  },
                  child: const Text(
                    'Hapus',
                    style: TextStyle(color: Colors.red),
                  )),
            ],
          );
        });
  }

  List<dynamic> data = [];

  void load() async {
    data = await networking.getJadwal();
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
        title: const Text('Atur jadwal'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          data.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 1),
                      child: Material(
                          elevation: 1,
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {
                              showDeleteDialog(data[i]['id']);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text('${i + 1}. ${data[i]['tanggal']}'),
                                ],
                              ),
                            ),
                          )),
                    );
                  },
                )
              : const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CupertinoActivityIndicator(),
                      Text('Memuat'),
                    ],
                  ),
                ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'Tekan untuk menghapus jadwal',
            style: TextStyle(color:  Color.fromARGB(255, 123, 123, 123)),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _selectDateTime(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
