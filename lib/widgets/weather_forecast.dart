class WeatherDay {
  final String day;
  final String humidity;
  final String moonImagePath;
  final String crescentMoonImagePath;
  final String currentTemperature;
  final String lowTemperature;

  WeatherDay({
    required this.day,
    required this.humidity,
    required this.moonImagePath,
    required this.crescentMoonImagePath,
    required this.currentTemperature,
    required this.lowTemperature,
  });

  factory WeatherDay.fromJson(Map<String, dynamic> json) {
    return WeatherDay(
      day: json['day'] ?? '',
      humidity: json['humidity'] ?? '',
      moonImagePath: json['moonImagePath'] ?? '',
      crescentMoonImagePath: json['crescentMoonImagePath'] ?? '',
      currentTemperature: json['currentTemperature'] ?? '',
      lowTemperature: json['lowTemperature'] ?? '',
    );
  }
}