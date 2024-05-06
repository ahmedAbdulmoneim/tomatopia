class AllUserModel {
  int? usersNumber;
  List<Users>? users;

  AllUserModel({this.usersNumber, this.users});

  AllUserModel.fromJson(Map<String, dynamic> json) {
    usersNumber = json['usersNumber'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(Users.fromJson(v));
      });
    }
  }


}

class Users {
  String? id;
  String? fullName;
  String? email;
  String? image;

  Users({this.id, this.fullName, this.email, this.image});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    image = json['image'];
  }


}
