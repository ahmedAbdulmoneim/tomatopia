class AiModel {
  String prediction ;

  AiModel({required this.prediction});

  factory AiModel.fromJson(Map<String,dynamic>json){
    return AiModel(
      prediction: json['prediction']
    );

  }
}