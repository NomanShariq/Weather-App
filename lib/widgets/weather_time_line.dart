import 'package:flutter/material.dart';

class WeatherTimelineItem extends StatelessWidget {
  final String time;
  final String temperature;
  final String imagePath;

  WeatherTimelineItem({
    required this.time,
    required this.temperature,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 11.5,
      ),
      child: Column(
        children: [
          Text(
            time,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 7),
          Image.asset(
            imagePath,
            height: 20,
          ),
          const SizedBox(height: 7),
          Text(
            temperature,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
