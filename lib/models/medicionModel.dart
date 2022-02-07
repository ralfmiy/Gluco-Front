class MedicionModel {
  final String? dia;
  final String? hora;
  final num? medida;
  final int? id;
  final int? count;
  MedicionModel({this.dia, this.medida, this.id, this.hora, this.count});

  factory MedicionModel.fromJson(Map<String, dynamic> json) {
    return MedicionModel(
      dia: json['measure_date'],
      medida: json['measurement'],
      id: json['id'],
    );
  }
}
