import 'package:flutter/material.dart';

class WeatherDayItem extends StatelessWidget {
  final String day;
  final String humidity;
  final String moonImagePath;
  final String crescentMoonImagePath;
  final String currentTemperature;
  final String lowTemperature;

  const WeatherDayItem({
    required this.day,
    required this.humidity,
    required this.moonImagePath,
    required this.crescentMoonImagePath,
    required this.currentTemperature,
    required this.lowTemperature,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
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
                    Text(
                      humidity,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 167, 162, 162),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 25,
                ),
                Image.asset(
                  moonImagePath,
                  height: 20,
                ),
                SizedBox(
                  width: 20,
                ),
                Image.asset(
                  crescentMoonImagePath,
                  height: 20,
                ),
                const Spacer(),
                Text(
                  currentTemperature,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const Spacer(),
                Text(
                  lowTemperature,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';

// class WeatherDayItem extends StatelessWidget {
//   final String day;
//   final String iconPath;
//   final String temperature;

//   const WeatherDayItem({
//     required this.day,
//     required this.iconPath,
//     required this.temperature,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             day,
//             style: TextStyle(fontSize: 18),
//           ),
//           Row(
//             children: [
//               Image.asset(
//                 iconPath,
//                 width: 24,
//                 height: 24,
//               ),
//               SizedBox(width: 8),
//               Text(
//                 temperature,
//                 style: TextStyle(fontSize: 18),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

