class UserModel {
  int? id;
  String? name;
  String? lastName;
  String? email;
  String? password;
  String? phone;
  

  UserModel(
      {
      this.id,
      this.name,
      this.lastName,
      this.email,
      this.password,
      this.phone}) {
    
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id:json['id'] ,
      name: json['name'],
      lastName: json['lastname'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
    );
  }
}
