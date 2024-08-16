class SignUpFormModel {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
 
  SignUpFormModel({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
   });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['password'] = password;
 

    return data;
  }
}
