import 'dart:convert';
import 'package:cuacaku/models/cuaca.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class CuacaService {
  static const baseUrl = 'http://api.openweathermap.org/data/2.5/weather';
  final String apiKey = '4a59ed4acde7c7dd2d4c5ca87e154b8a'; //api key yg di dapatkan di web https://home.openweathermap.org/

  Future<Cuaca> getCuaca(String namaKota)async{
    final response = await http.get(Uri.parse('$baseUrl?q=$namaKota&appid=$apiKey&units=metric'));
    if(response.statusCode == 200){
      return Cuaca.fromJson(json.decode(response.body));
    }else{
      throw Exception('Data gagal dimuat');
    }
  }

  Future<String> getCuacaSaatIni()async{
    //mengambil izin dari user
    LocationPermission izin = await Geolocator.checkPermission();
    if(izin == LocationPermission.denied){
      izin = await Geolocator.requestPermission();
    }

    //mengambil posisi user| fetch
    Position posisi = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    //menkonversi lokasi kedalam List objek tempat
    List<Placemark> tempat = await placemarkFromCoordinates(posisi.latitude, posisi.longitude);

    //mengektrak nama kota saat pertamakali lokasi dideteksi
    String? kota = tempat[0].locality;

    return kota ?? "";
  }
}
