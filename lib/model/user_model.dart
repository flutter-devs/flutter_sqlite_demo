class UserModel {
  int? id;
  String name;
  String email;
  String desc;

  UserModel({this.id, required this.name, required this.email, required this.desc});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'desc': desc,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      desc: map['desc'],
    );
  }
}
