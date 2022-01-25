class LoginModel {
  int? id;
  String? name;
  String? lastname;
  String? email;
  String? password;
  String? phone;
  String? token;

  LoginModel({
    this.id,
    this.name,
    this.lastname,
    this.email,
    this.phone,
    this.token,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
        id: json['id'],
        name: json['name'],
        lastname: json['lastname'],
        email: json['email'],
        phone: json['phone'],
        token: json['token']);
  }
}
