import 'package:flutter/material.dart';
import 'package:guru_booking/admin/daftar_guru.dart';
import 'package:guru_booking/admin/daftar_siswa.dart';
import 'package:guru_booking/admin/kategori.dart';
import 'package:guru_booking/admin/profil.dart';
import 'package:guru_booking/utils/styles.dart';

final styles = Styles();

class DashboardAdmin extends StatefulWidget {
  const DashboardAdmin({super.key, required this.index});
  final int index;

  @override
  State<DashboardAdmin> createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
  String title = 'Daftar siswa';

  List<Widget> widgets = [
    const DaftarSiswa(),
    const DaftarGuru(),
    const KategoriAdmin(),
    const ProfilAdmin()
  ];

  List<String> titles = [
    'Daftar siswa',
    'Daftar guru',
    'Kategori',
    'Profil',
  ];

  int currentIndex = 0;
  void setIndex(int index) {
    setState(() {
      currentIndex = index;
      title = titles[index];
    });
  }

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titles[currentIndex]),),
      body: widgets.elementAt(currentIndex),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: currentIndex,
          onTap: setIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: 'Daftar siswa'),
            BottomNavigationBarItem(
                icon: Icon(Icons.group), label: 'Daftar guru'),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Kategori'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          ]),
    );
  }
}
