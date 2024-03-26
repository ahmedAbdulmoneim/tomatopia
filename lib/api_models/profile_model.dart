class ProfileModel{
  final String id ;
   String name ;
   String email;
  ProfileModel({required this.name,required this.email,required this.id});

  factory ProfileModel.fromJson(Map<String,dynamic> json){
    return ProfileModel(
        name: json['fullName'],
        email: json['email'],
        id: json['id'],
    );
  }
}