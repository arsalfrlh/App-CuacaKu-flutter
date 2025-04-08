import 'package:cuacaku/models/cuaca.dart';
import 'package:cuacaku/services/cuaca_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
//utk ios gunakan izin akses lokasi di "ios/Runner/info.plist" tambahkan "<key>NSLocationWhenInUseUsageDescription</key>"
//utk android gunakan izin akses lokasi di  "android/app/src/main/AndroidManifest.xml"
//ubh konfigurasi versi di "android/setting.gradle"

class CuacaPage extends StatefulWidget {
  @override
  _CuacaPageState createState() => _CuacaPageState();
}

class _CuacaPageState extends State<CuacaPage> {
  final CuacaService cuacaService = CuacaService();
  Cuaca? _cuaca;

  fetchCuaca() async {
    String namaKota = await cuacaService
        .getCuacaSaatIni(); //memanggil class CuacaService dan function getCuacaSaatIni

    try {
      final cuaca = await cuacaService.getCuaca(
          namaKota); //memanggil class CuacaService dan function getCuaca
      setState(() {
        _cuaca = cuaca;
      });
    } catch (e) {
      print(e);
    }
  }

  String getCuacaAnimasi(String? _kondisiCuaca) {
    if (_kondisiCuaca == null) return 'assets/sunny.json';
    switch (_kondisiCuaca.toLowerCase()) {
      //animasi akan sesuai dengan isi array key API
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCuaca();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[800],
        appBar: AppBar(
          title: Text(
            'Made by Kwanzzx',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Kota: ${_cuaca?.namaKota}' ?? "Loading",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),

              Lottie.asset(getCuacaAnimasi(
                  _cuaca?.kondisiCuaca)), //memanggil function getCuaca

              Text(
                'Suhu: ${_cuaca?.temperature.round()}°C',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.orange,
                ),
              ),

              Text(
                _cuaca?.kondisiCuaca ?? "",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ));
  }
}
