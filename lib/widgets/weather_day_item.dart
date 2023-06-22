import 'package:flutter/material.dart';

class WeatherDayItem extends StatelessWidget {
  final String day;
  final double temperature;
  final double temperature2;
  final int humidity;
  final String iconPath;
  final String iconPath2;

  const WeatherDayItem({super.key, 
    required this.day,
    required this.temperature,
    required this.temperature2,
    required this.humidity,
    required this.iconPath,
    required this.iconPath2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              day,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            width: 200,
            child: Row(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.water_drop,
                      color: Color.fromARGB(255, 139, 136, 136),
                      size: 13,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '$humidity%',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 167, 162, 162),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Image.asset(
                  iconPath,
                  height: 20,
                ),
                const SizedBox(width: 10),
                Image.asset(
                  iconPath2,
                  height: 20,
                ),
                const SizedBox(width: 10),
                Row(
                  children: [
                    Text(
                      ' ${temperature.toStringAsFixed(0)}°',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '${temperature2.toStringAsFixed(0)}°',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
