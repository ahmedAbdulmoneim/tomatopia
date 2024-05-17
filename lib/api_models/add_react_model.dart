class AddReactModel{
  final int id ;
  final int likes ;
  final int disLikes ;

  AddReactModel({
    required this.id,
    required this.likes,
    required this.disLikes,
});

  factory AddReactModel.fromJson(Map<String,dynamic>json){
    return AddReactModel(
        id: json['postId'],
        likes: json['likes'],
        disLikes: json['dislikes']);
  }
}