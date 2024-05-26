//
//
// class GetPostsModel {
//   final int id;
//   final String content;
//   final String? image;
//   final String userImage;
//   final String creationDate;
//   final int likes;
//   final int disLikes;
//   final List<dynamic> comments;
//   final String userId;
//   final String userName;
//
//   GetPostsModel({
//     required this.id,
//     required this.content,
//     this.image,
//     required this.userImage,
//     required this.creationDate,
//     required this.likes,
//     required this.disLikes,
//     required this.comments,
//     required this.userId,
//     required this.userName,
//   });
//
//   factory GetPostsModel.fromJson(Map<String, dynamic> json) {
//     return GetPostsModel(
//       id: json['id'],
//       content: json['content'],
//       image: json['image'],
//       userImage: json['userImage'],
//       creationDate: json['creationDate'],
//       likes: json['likes'],
//       disLikes: json['disLikes'],
//       comments: json['comments'],
//       userId: json['userId'],
//       userName: json['userName'],
//     );
//   }
// }

import 'dart:convert';

class Comment {
  int id;
  String content;
  String? image;
  String creationDate;
  int likes;
  int disLikes;
  List<Comment> comments;
  String userName;
  String userImage;
  String userId;

  Comment({
    required this.id,
    required this.content,
    this.image,
    required this.creationDate,
    required this.likes,
    required this.disLikes,
    required this.comments,
    required this.userName,
    required this.userImage,
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
      comments: (json['comments'] as List)
          .map((commentJson) => Comment.fromJson(commentJson))
          .toList(),
      userName: json['userName'],
      userImage: json['userImage'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'image': image,
      'creationDate': creationDate,
      'likes': likes,
      'disLikes': disLikes,
      'comments': comments.map((comment) => comment.toJson()).toList(),
      'userName': userName,
      'userImage': userImage,
      'userId': userId,
    };
  }
}

class GetPostsModel {
  int id;
  String content;
  String? image;
  String creationDate;
  int likes;
  int disLikes;
  List<Comment> comments;
  String userName;
  String userImage;
  String userId;

  GetPostsModel({
    required this.id,
    required this.content,
    this.image,
    required this.creationDate,
    required this.likes,
    required this.disLikes,
    required this.comments,
    required this.userName,
    required this.userImage,
    required this.userId,
  });

  factory GetPostsModel.fromJson(Map<String, dynamic> json) {
    return GetPostsModel(
      id: json['id'],
      content: json['content'],
      image: json['image'],
      creationDate: json['creationDate'],
      likes: json['likes'],
      disLikes: json['disLikes'],
      comments: (json['comments'] as List)
          .map((commentJson) => Comment.fromJson(commentJson))
          .toList(),
      userName: json['userName'],
      userImage: json['userImage'],
      userId: json['userId'],
    );
  }


}

// Example usage:
