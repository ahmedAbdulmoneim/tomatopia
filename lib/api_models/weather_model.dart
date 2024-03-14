class WeatherModel {
  final double currentTemp;
  final String currentImage;
  final String currentCondition;
  final String cityName;
  final String cityPronunciation;
  final List<String> dates;
  final List<double> temps;
  final List<double> maxTemps;
  final List<dynamic> rains;
  final List<double> winds;
  final List<double> minTemps;
  final List<String> weatherConditions;
  final List<String> images;

  WeatherModel({
    required this.cityPronunciation,
    required this.currentCondition,
    required this.currentImage,
    required this.currentTemp,
    required this.cityName,
    required this.winds,
    required this.rains,
    required this.dates,
    required this.temps,
    required this.maxTemps,
    required this.minTemps,
    required this.weatherConditions,
    required this.images,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    List<String> dates = [];
    List<dynamic> rains = [];
    List<double> winds = [];
    List<double> temps = [];
    List<double> maxTemps = [];
    List<double> minTemps = [];
    List<String> weatherConditions = [];
    List<String> images = [];

    // Assuming 'forecastday' contains data for 3 days
    for (int i = 0; i < 3; i++) {
      dates.add(json['forecast']['forecastday'][i]['date']);
      rains.add(
          json['forecast']['forecastday'][i]['day']['daily_chance_of_rain']);
      winds.add(json['forecast']['forecastday'][i]['day']['maxwind_kph']);
      temps.add(json['forecast']['forecastday'][i]['day']['avgtemp_c']);
      maxTemps.add(json['forecast']['forecastday'][i]['day']['maxtemp_c']);
      minTemps.add(json['forecast']['forecastday'][i]['day']['mintemp_c']);
      weatherConditions
          .add(json['forecast']['forecastday'][i]['day']['condition']['text']);
      images
          .add(json['forecast']['forecastday'][i]['day']['condition']['icon']);
    }

    return WeatherModel(
      cityName: json['location']['name'],
      cityPronunciation: json['location']['region'],
      currentCondition: json['current']['condition']['text'],
      currentImage: json['current']['condition']['icon'],
      currentTemp: json['current']['temp_c'],
      dates: dates,
      rains: rains,
      winds: winds,
      temps: temps,
      maxTemps: maxTemps,
      minTemps: minTemps,
      weatherConditions: weatherConditions,
      images: images,
    );
  }
}
