class ProfileModel {
  String name;
  String email;
  String? image;

  ProfileModel({
    required this.name,
    required this.email,
    this.image,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    var image = json['image'];
    if (image is Map) {
      // Handle if 'image' is a nested map (unlikely in your case, but for completeness)
      image = image['url']; // or some other nested value
    }
    return ProfileModel(
      name: json['fullName'],
      email: json['email'],
      image: image as String?, // Cast to String? if necessary
    );
  }

}
