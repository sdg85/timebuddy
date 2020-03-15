class User {
  final String id;
  final String email;
  final String firstname;
  final String lastname;
  final String photo;

  User({this.id, this.email, this.firstname, this.lastname, this.photo});

  User.fromData(Map<String, dynamic> data)
      : id = data["uid"],
        email = data["email"],
        firstname = data["firstName"],
        lastname = data["lastName"],
        photo = data["photo"];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstname,
      'lastName': lastname,
      'photo': photo
    };
  }
}
