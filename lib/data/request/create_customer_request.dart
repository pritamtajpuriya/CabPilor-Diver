class CreateCustomerRequest {
  String? name;
  String? email;
  String? phone;
  String? password;
  String? adress;

  CreateCustomerRequest({
    this.name,
    this.email,
    this.phone,
    this.password,
    this.adress,
  });

  factory CreateCustomerRequest.fromJson(Map<String, dynamic> json) =>
      CreateCustomerRequest(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        password: json["password"],
        adress: json["adress"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "adress": adress,
      };
}
