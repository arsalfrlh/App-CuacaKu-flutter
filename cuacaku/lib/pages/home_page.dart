import 'package:cuacaku/pages/cari_page.dart';
import 'package:cuacaku/pages/cuaca_page.dart';
import 'package:cuacaku/services/cuaca_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CuacaService cuacaService = CuacaService();
  final namaKotaController = TextEditingController();

  void _getCariCuaca()async{
    await cuacaService.getCariCuaca(namaKotaController.text);
    Navigator.push(context, MaterialPageRoute(builder: (context) => CariPage(cariKota: namaKotaController.text,)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => CuacaPage()));
          }, child: Text('Kota Saya'), style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),)
        ],
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    "Cuaca Ku",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Aplikasi Tracking Cuaca",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF757575)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                  CariNamaKota(namaKotaController: namaKotaController, getCariCuaca: _getCariCuaca,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

const authOutlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Color(0xFF757575)),
  borderRadius: BorderRadius.all(Radius.circular(100)),
);

class CariNamaKota extends StatelessWidget {
  TextEditingController namaKotaController;
  VoidCallback getCariCuaca;
  CariNamaKota({required this.namaKotaController, required this.getCariCuaca});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: namaKotaController,
            decoration: InputDecoration(
                hintText: "Masukkan Nama Kota",
                labelText: "Kota",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintStyle: const TextStyle(color: Color(0xFF757575)),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                border: authOutlineInputBorder,
                enabledBorder: authOutlineInputBorder,
                focusedBorder: authOutlineInputBorder.copyWith(
                    borderSide: const BorderSide(color: Color(0xFFFF7643)))),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          ElevatedButton(
            onPressed: getCariCuaca,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: const Color(0xFFFF7643),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 48),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
            child: const Text("Cari"),
          )
        ],
      ),
    );
  }
}