class MedicionModel {
  final String? dia;
  final num? medida;
  final int? id;
  final int? user_id;
  MedicionModel({this.dia, this.medida, this.id, this.user_id});

   factory MedicionModel.fromJson(Map<String, dynamic> json) {
    return MedicionModel(
      dia:json['measure_date'] ,
      medida: json['measurement'],
      id: json['id'],
      user_id: json['user_id'],
    );
  }
}