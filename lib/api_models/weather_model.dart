class WeatherModel {
  Location? location;
  Forecast? forecast;

  WeatherModel({this.location, this.forecast});

  WeatherModel.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ?  Location.fromJson(json['location'])
        : null;
  }
}

class Location {
  String? region;

  Location({
    this.region,
  });

  Location.fromJson(Map<String, dynamic> json) {
    region = json['region'];
  }
}

class Condition {
  String? text;
  String? icon;

  Condition({this.text, this.icon});

  Condition.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    icon = json['icon'];
  }
}

class Forecast {
  List<Forecastday>? forecastday;

  Forecast({this.forecastday});

  Forecast.fromJson(Map<String, dynamic> json) {
    if (json['forecastday'] != null) {
      forecastday = <Forecastday>[];
      json['forecastday'].forEach((v) {
        forecastday!.add(Forecastday.fromJson(v));
      });
    }
  }
}

class Forecastday {
  Day? day;

  Forecastday({this.day});

  Forecastday.fromJson(Map<String, dynamic> json) {
    day = json['day'] != null ? Day.fromJson(json['day']) : null;
  }
}

class Day {
  double? maxtempC;
  double? mintempC;

  double? maxwindKph;

  int? dailyChanceOfRain;

  Condition? condition;

  Day({
    this.maxtempC,
    this.mintempC,
    this.maxwindKph,
    this.dailyChanceOfRain,
    this.condition,
  });

  Day.fromJson(Map<String, dynamic> json) {
    maxtempC = json['maxtemp_c'];
    mintempC = json['mintemp_c'];

    maxwindKph = json['maxwind_kph'];

    dailyChanceOfRain = json['daily_chance_of_rain'];

    condition = json['condition'] != null
        ? Condition.fromJson(json['condition'])
        : null;
  }
}
