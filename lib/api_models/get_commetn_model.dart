class Comment {
  int id;
  String content;
  String? image;
  String creationDate;
  int likes;
  int disLikes;
  String userName;
  String? userImage;
  String userId;

  Comment({
    required this.id,
    required this.content,
    this.image,
    required this.creationDate,
    required this.likes,
    required this.disLikes,

    required this.userName,
    this.userImage,
    required this.userId,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      content: json['content'],
      image: json['image'],
      creationDate: json['creationDate'],
      likes: json['likes'],
      disLikes: json['disLikes'],
      userName: json['userName'],
      userImage: json['userImage'],
      userId: json['userId'],
    );
  }


}
