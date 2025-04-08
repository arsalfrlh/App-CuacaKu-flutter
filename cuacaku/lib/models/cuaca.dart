class Cuaca {
  final String namaKota;
  final double temperature;
  final String kondisiCuaca;

  Cuaca({required this.namaKota, required this.temperature, required this.kondisiCuaca});

  factory Cuaca.fromJson(Map<String, dynamic> json){
    return Cuaca(
      namaKota: json['name'],
      temperature: json['main']['temp'].toDouble(), //data dynamic di konversi menjdi double
      kondisiCuaca: json['weather'][0]['main'],
    );
  }
}
