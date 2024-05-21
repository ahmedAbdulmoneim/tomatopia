class ProfileModel{

   String name ;
   String email;
   String image;
  ProfileModel({required this.name,required this.email,required this.image});

  factory ProfileModel.fromJson(Map<String,dynamic> json){
    return ProfileModel(
        name: json['fullName'],
        email: json['email'],
        image: json['image'],
    );
  }
}