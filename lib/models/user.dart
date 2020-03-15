class User {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String photo;

  User({this.id, this.email, this.firstName, this.lastName, this.photo});

  User.fromData(Map<String, dynamic> data)
      : id = data["uid"],
        email = data["email"],
        firstName = data["firstName"],
        lastName = data["lastName"],
        photo = data["photo"];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'photo': photo
    };
  }
}
