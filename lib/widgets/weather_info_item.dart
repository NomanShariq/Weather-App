import 'package:flutter/material.dart';

class WeatherInfoItem extends StatelessWidget {
  final String title;
  final String description;

  const WeatherInfoItem({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          Text(
            description,
            style: const TextStyle(
              color: Color.fromARGB(255, 181, 179, 179),
            ),
          ),
        ],
      ),
    );
  }
}
