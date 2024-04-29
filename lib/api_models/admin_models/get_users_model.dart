class AllUsersModel {
  int? allUserNumber;
  List<Users>? users;

  AllUsersModel({this.allUserNumber, this.users});

  AllUsersModel.fromJson(Map<String, dynamic> json) {
    allUserNumber = json['allUserNumber'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add( Users.fromJson(v));
      });
    }
  }


}

class Users {
  String? id;
  String? fullName;
  String? email;

  Users({this.id, this.fullName, this.email});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
  }


}
