import 'package:flutter/material.dart';
import 'package:guru_booking/siswa/categories.dart';
import 'package:guru_booking/siswa/history.dart';
import 'package:guru_booking/siswa/home.dart';
import 'package:guru_booking/siswa/notifikasi.dart';
import 'package:guru_booking/siswa/profile.dart';
import 'package:guru_booking/utils/tools.dart';

class DashboardSiswa extends StatefulWidget {
  const DashboardSiswa({super.key,required this.index});
  final int index;

  @override
  State<DashboardSiswa> createState() => _DashboardState();
}

class _DashboardState extends State<DashboardSiswa> {
  String title = 'Beranda';
  List<Widget> widgets = [
    const HomeSiswa(),
    const CategoriesSiswa(),
    const HistorySiswa(),
    const ProfileSiswa()
  ];
  int selectedIndex = 0;

  List<String> titles = ['Beranda', 'Kategori', 'Riwayat order', 'Profil'];

  AppBar myAppBar(int index) {
    if (index == 0) {
      return AppBar(
        title: Text(titles[index]),
        actions: [
          IconButton(onPressed: () {
            Tools().Navigate(context, const Notifikasi());
          }, icon: const Icon(Icons.notifications))
        ],
      );
    } else {
      return AppBar(
        title: Text(titles[index]),
      );
    }
  }

  void selectIndex(int index) {
    setState(() {
      selectedIndex = index;
      title = titles[index];
    });
  }

  @override
  void initState() {
    super.initState();
    selectIndex(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: myAppBar(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Kategori'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Riwayat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
        currentIndex: selectedIndex,
        onTap: selectIndex,
      ),
      body: widgets.elementAt(selectedIndex),
    );
  }
}
