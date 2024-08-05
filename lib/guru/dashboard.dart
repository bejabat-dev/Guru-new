import 'package:flutter/material.dart';
import 'package:guru_booking/guru/kategori.dart';
import 'package:guru_booking/guru/order.dart';
import 'package:guru_booking/guru/profil.dart';
import 'package:guru_booking/guru/riwayat.dart';

class DashboardGuru extends StatefulWidget {
  const DashboardGuru({super.key,required this.index});
  final int index;

  @override
  State<DashboardGuru> createState() => _DashboardGuruState();
}

class _DashboardGuruState extends State<DashboardGuru> {
  String title = 'Order masuk';


  int currentIndex = 0;
  void selectIndex(int index) {
    setState(() {
      currentIndex = index;
      title = titles[index];
    });
  }

  List<Widget> widgets = [
    const OrderMasuk(),
    const KategoriGuru(),
    const RiwayatGuru(),
    const ProfilGuru()
  ];

  List<String> titles = [
    'Order masuk',
    'Kategori',
    'Riwayat',
    'Profil',
  ];

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: widgets.elementAt(currentIndex),
      
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red,
          onTap: selectIndex,
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_checkout), label: 'Order masuk'),
            BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Kategori'),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Riwayat'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          ]),
    );
  }
}
