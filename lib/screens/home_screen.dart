import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/widgets/weather_day_item.dart';
import 'package:weather_app/widgets/weather_info_item.dart';
import '../widgets/custom_weather_info_item.dart';
import '../widgets/weather_time_line.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController = ScrollController();
  Color _backgroundColor = const Color.fromARGB(255, 43, 64, 81);
  String _temperature = '';
  String _city = '';
  String _weatherDescription = '';
  String _sunrise = '';
  String _sunset = '';
  String _humidity = '';
  String _windSpeed = '';
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _fetchWeatherData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 100) {
      setState(() {
        _backgroundColor =
            Colors.black; // Change to the desired background color
      });
    } else {
      setState(() {
        _backgroundColor = const Color.fromARGB(
            255, 43, 64, 81); // Set the default background color
      });
    }
  }

  Future<void> _fetchWeatherData() async {
    String flag =
        'q'; // You can change this to 'id' if you want to search by city ID
    String entryText =
        'Karachi'; // Replace this with your desired city name or ID
    String units = 'metric'; // You can change this to 'imperial' for Fahrenheit
    String WEATHER_API_KEY =
        '285d2f45568802d9e40df8adecc4a754'; // Replace this with your OpenWeatherMap API key

    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?$flag=$entryText&units=$units&appid=$WEATHER_API_KEY');

    try {
      var response = await http.get(url);
      var data = json.decode(response.body);

      setState(() {
        _temperature = data['main']['temp'].round().toString();
        _city = data['name'];
        _weatherDescription = data['weather'][0]['description'];
        _sunrise = _convertTimestampToTime(data['sys']['sunrise']);
        _sunset = _convertTimestampToTime(data['sys']['sunset']);
        _humidity = data['main']['humidity'].toString();
        _windSpeed = data['wind']['speed'].toString();
      });
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  String _convertTimestampToTime(int timestamp) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var timeFormat = DateFormat.jm();
    return timeFormat.format(dateTime);
  }

  String _getDayOfWeek(int timestamp) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var dayFormat = DateFormat('EEEE');
    return dayFormat.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
            size: 30,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Search'),
                    content: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        hintText: 'Search your city here',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                        onPressed: () {
                          // Handle submit button action here
                        },
                        child: Text('Submit',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(
              Icons.search,
              size: 30,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 270,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '$_temperature°C',
                                    style: const TextStyle(
                                        fontSize: 72, color: Colors.white),
                                  ),
                                  Text(
                                    _city,
                                    style: const TextStyle(
                                        fontSize: 24, color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    '$_weatherDescription',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  // Text(
                                  //   'Sun, 12:46 Am',
                                  //   style: TextStyle(
                                  //     fontSize: 15,
                                  //     fontWeight: FontWeight.bold,
                                  //     color: Colors.white,
                                  //   ),
                                  // )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Image.asset(
                                  "assets/images/moon.png",
                                  height: 120,
                                  alignment: Alignment.topRight,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 380,
                    height: 180,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(110, 179, 185, 245),
                      borderRadius: BorderRadius.all(
                        Radius.circular(23),
                      ),
                    ),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Stack(
                            children: [
                              Row(
                                children: [
                                  WeatherTimelineItem(
                                    temperature: '29°',
                                    time: '1 am',
                                    imagePath: 'assets/images/Icon.png',
                                  ),
                                  WeatherTimelineItem(
                                    temperature: '29°',
                                    time: '2 am',
                                    imagePath: 'assets/images/Icon.png',
                                  ),
                                  WeatherTimelineItem(
                                    temperature: '29°',
                                    time: '3 am',
                                    imagePath: 'assets/images/Icon.png',
                                  ),
                                  WeatherTimelineItem(
                                    temperature: '29°',
                                    time: '4 am',
                                    imagePath: 'assets/images/Icon.png',
                                  ),
                                  WeatherTimelineItem(
                                    temperature: '29°',
                                    time: '5 am',
                                    imagePath: 'assets/images/Icon.png',
                                  ),
                                  WeatherTimelineItem(
                                    temperature: '29°',
                                    time: '6 am',
                                    imagePath: 'assets/images/Icon.png',
                                  ),
                                  WeatherTimelineItem(
                                    temperature: '29°',
                                    time: '7 am',
                                    imagePath: 'assets/images/Icon.png',
                                  ),
                                  WeatherTimelineItem(
                                    temperature: '29°',
                                    time: '8 am',
                                    imagePath: 'assets/images/Icon.png',
                                  ),
                                  WeatherTimelineItem(
                                    temperature: '29°',
                                    time: '9 am',
                                    imagePath: 'assets/images/Icon.png',
                                  ),
                                  WeatherTimelineItem(
                                    temperature: '29°',
                                    time: '10 am',
                                    imagePath: 'assets/images/Icon.png',
                                  ),
                                  WeatherTimelineItem(
                                    temperature: '29°',
                                    time: '11 am',
                                    imagePath: 'assets/images/Icon.png',
                                  ),
                                  WeatherTimelineItem(
                                    temperature: '29°',
                                    time: '12 apm',
                                    imagePath: 'assets/images/Icon.png',
                                  ),
                                  WeatherTimelineItem(
                                    temperature: '29°',
                                    time: '1 pm',
                                    imagePath: 'assets/images/Icon.png',
                                  ),
                                  WeatherTimelineItem(
                                    temperature: '29°',
                                    time: '2 pm',
                                    imagePath: 'assets/images/Icon.png',
                                  ),
                                  WeatherTimelineItem(
                                    temperature: '29°',
                                    time: '3 pm',
                                    imagePath: 'assets/images/Icon.png',
                                  ),
                                  WeatherTimelineItem(
                                    temperature: '29°',
                                    time: '4 pm',
                                    imagePath: 'assets/images/Icon.png',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 380,
                    height: 100,
                    padding: const EdgeInsets.only(top: 20),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(110, 179, 185, 245),
                      borderRadius: BorderRadius.all(
                        Radius.circular(23),
                      ),
                    ),
                    child: CarouselSlider(
                      options: CarouselOptions(
                          enlargeCenterPage: true,
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 1900),
                          viewportFraction: 8.0),
                      items: const [
                        WeatherInfoItem(
                          title: "Today's Feel Like Temperature",
                          description: "Humidity will make you like feel 42°",
                        ),
                        WeatherInfoItem(
                          title: 'Protect Your Skin',
                          description:
                              'UV will be extreme. Limit sun exposure if possible',
                        ),
                        WeatherInfoItem(
                          title: 'Rise and Shine',
                          description: 'Sunrise will be at 5:41 am',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 380,
                    height: 332,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(110, 179, 185, 245),
                      borderRadius: BorderRadius.all(
                        Radius.circular(23),
                      ),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                      child: Column(children: [
                        WeatherDayItem(
                            day: 'Monday',
                            humidity: '2%',
                            moonImagePath: 'assets/images/moonandcloud.png',
                            crescentMoonImagePath:
                                'assets/images/cresentmoon.png',
                            currentTemperature: '34°',
                            lowTemperature: '29°'),
                        WeatherDayItem(
                          day: 'Today',
                          humidity: '3%',
                          moonImagePath: 'assets/images/sun.png',
                          crescentMoonImagePath:
                              'assets/images/cresentmoon.png',
                          currentTemperature: '35°',
                          lowTemperature: '29°',
                        ),
                        WeatherDayItem(
                          day: 'Wednesday',
                          humidity: '5%',
                          moonImagePath: 'assets/images/sun.png',
                          crescentMoonImagePath:
                              'assets/images/cresentmoon.png',
                          currentTemperature: '35°',
                          lowTemperature: '29°',
                        ),
                        WeatherDayItem(
                          day: 'Thursday',
                          humidity: '5%',
                          moonImagePath: 'assets/images/moonandcloud.png',
                          crescentMoonImagePath:
                              'assets/images/cresentmoon.png',
                          currentTemperature: '35°',
                          lowTemperature: '28°',
                        ),
                        WeatherDayItem(
                          day: 'Friday',
                          humidity: '5%',
                          moonImagePath: 'assets/images/sun.png',
                          crescentMoonImagePath:
                              'assets/images/cresentmoon.png',
                          currentTemperature: '35°',
                          lowTemperature: '28°',
                        ),
                        WeatherDayItem(
                          day: 'Saturday',
                          humidity: '5%',
                          moonImagePath: 'assets/images/sun.png',
                          crescentMoonImagePath:
                              'assets/images/cresentmoon.png',
                          currentTemperature: '35°',
                          lowTemperature: '28°',
                        ),
                        WeatherDayItem(
                          day: 'Sunday',
                          humidity: '5%',
                          moonImagePath: 'assets/images/sun.png',
                          crescentMoonImagePath:
                              'assets/images/cresentmoon.png',
                          currentTemperature: '35°',
                          lowTemperature: '29°',
                        ),
                      ]),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 380,
                    height: 130,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(110, 179, 185, 245),
                      borderRadius: BorderRadius.all(
                        Radius.circular(23),
                      ),
                    ),
                    child: Row(children: [
                      Expanded(
                        child: Container(
                            width: 100,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Sunrise',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    '$_sunrise ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Image.asset(
                                    "assets/images/sunrise.png",
                                    width: 120,
                                  )
                                ])),
                      ),
                      Expanded(
                        child: Container(
                            width: 100,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Sunset',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    '$_sunset ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Image.asset(
                                    "assets/images/sunset.png",
                                    width: 120,
                                  )
                                ])),
                      ),
                    ]),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 380,
                    height: 150,
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(110, 179, 185, 245),
                      borderRadius: BorderRadius.all(
                        Radius.circular(23),
                      ),
                    ),
                    child: Row(
                      children: [
                        CustomWeatherInfoItem(
                          icon: Icons.sunny,
                          title: "UV index",
                          value: "Low",
                          iconColor: Color.fromARGB(255, 255, 203, 28),
                        ),
                        CustomWeatherInfoItem(
                          icon: Icons.water_drop,
                          title: 'Humidity',
                          value: '$_humidity%',
                          iconColor: Color.fromARGB(255, 152, 218, 249),
                        ),
                        CustomWeatherInfoItem(
                          icon: Icons.air,
                          title: 'Wind',
                          value: '$_windSpeed km/h',
                          iconColor: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//   String _convertTimestampToTime(int timestamp) {
//     var dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
//     var timeFormat = DateFormat.jm();
//     return timeFormat.format(dateTime);
//   }

//   String _getDayOfWeek(int timestamp) {
//     var dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
//     var dayFormat = DateFormat('EEEE');
//     return dayFormat.format(dateTime);
//   }

//   String _getWeatherIcon(int weatherId) {
//     if (weatherId >= 200 && weatherId <= 232) {
//       return 'assets/images/moon.png';
//     } else if (weatherId >= 300 && weatherId <= 321) {
//       return 'assets/images/moon.png';
//     } else if (weatherId >= 500 && weatherId <= 531) {
//       return 'assets/images/moon.png';
//     } else if (weatherId >= 600 && weatherId <= 622) {
//       return 'assets/images/moon.png';
//     } else if (weatherId >= 701 && weatherId <= 781) {
//       return 'assets/images/mist.png';
//     } else if (weatherId == 800) {
//       return 'assets/images/moon.png';
//     } else if (weatherId >= 801 && weatherId <= 804) {
//       return 'assets/images/moon.png';
//     } else {
//       return 'assets/images/moon.png';
//     }
//   }

//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               child: CarouselSlider(
//                 options: CarouselOptions(
//                   height: 120,
//                   enlargeCenterPage: true,
//                   enableInfiniteScroll: false,
//                 ),
//                 items: [
//                   WeatherTimelineItem(
//                     day: _getDayOfWeek(
//                         DateTime.now().millisecondsSinceEpoch ~/ 1000),
//                     iconPath: _getWeatherIcon(800),
//                     temperature: '25°C',
//                   ),
//                   WeatherTimelineItem(
//                     day: _getDayOfWeek(DateTime.now()
//                             .add(const Duration(days: 1))
//                             .millisecondsSinceEpoch ~/
//                         1000),
//                     iconPath: _getWeatherIcon(801),
//                     temperature: '22°C',
//                   ),
//                   WeatherTimelineItem(
//                     day: _getDayOfWeek(DateTime.now()
//                             .add(const Duration(days: 2))
//                             .millisecondsSinceEpoch ~/
//                         1000),
//                     iconPath: _getWeatherIcon(500),
//                     temperature: '18°C',
//                   ),
//                   WeatherTimelineItem(
//                     day: _getDayOfWeek(DateTime.now()
//                             .add(const Duration(days: 3))
//                             .millisecondsSinceEpoch ~/
//                         1000),
//                     iconPath: _getWeatherIcon(802),
//                     temperature: '20°C',
//                   ),
//                 ],
//               ),
//             ),
//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: 5,
//               itemBuilder: (context, index) {
//                 return WeatherDayItem(
//                   day: _getDayOfWeek(DateTime.now()
//                           .add(Duration(days: index + 1))
//                           .millisecondsSinceEpoch ~/
//                       1000),
//                   iconPath: _getWeatherIcon(802),
//                   temperature: '20°C',
//                 );
//               },
//             ),
//            
//         ),
//       ),
//     );
//   }
// }

