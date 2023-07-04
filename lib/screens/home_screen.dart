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
  SearchController _searchController = SearchController();
  Color _backgroundColor = const Color.fromARGB(255, 43, 64, 81);
  String _temperature = '';
  String _city = '';
  String _weatherDescription = '';
  String _sunrise = '';
  String _sunset = '';
  String _humidity = '';
  String _windSpeed = '';
  bool loading = true;
  List<Map<String, dynamic>> forecastData = [];

  List<Map<String, dynamic>> weatherData = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _fetchWeatherData();
    fetchsWeatherData();
    fetchHourlyForecast();
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

  Future<void> fetchHourlyForecast() async {
    // final apiKey = '0NSY9T1tFGo0NIXOYp23lro8DsuOcwPJ';
    // final locationKey = '55488';
    final url =
        'http://dataservice.accuweather.com/forecasts/v1/hourly/12hour/261158?apikey=f8GASRMPCckG9EZ9isdmLNGuiLsWjsVn';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<Map<String, dynamic>> hourlyForecastData = [];

      for (var forecastItem in jsonData) {
        final temperatureFahrenheit = forecastItem['Temperature']['Value'];
        final temperatureCelsius = (temperatureFahrenheit - 32) * 5 / 9;

        final temperatureFormat = NumberFormat('0');
        final temperature = temperatureFormat.format(temperatureCelsius);
        final dateTimeString = forecastItem['DateTime'];
        final dateTime = DateTime.parse(dateTimeString);
        final timeFormat = DateFormat.jm();
        final localTime = dateTime.toLocal();
        final time = timeFormat.format(localTime);

        final forecastMap = {
          'temperature': temperature,
          'time': time,
          'imagePath': 'assets/images/Icon.png',
        };

        hourlyForecastData.add(forecastMap);
      }

      setState(() {
        forecastData = hourlyForecastData;
      });
    } else {
      throw Exception('Failed to fetch hourly forecast');
    }
  }

  Future<void> fetchsWeatherData() async {
    try {
      final fetchedData = await fetchWeatherForecast();
      setState(() {
        weatherData = fetchedData;
      });
    } catch (error) {
      print('Error fetching weather data: $error');
      // Handle error here
    }
  }

  Future<List<Map<String, dynamic>>> fetchWeatherForecast() async {
    final url =
        'https://api.openweathermap.org/data/2.5/forecast?lat=24.821962&lon=67.041426&appid=285d2f45568802d9e40df8adecc4a754';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<Map<String, dynamic>> forecastData = [];

      final dateFormatter = DateFormat('EEEE');

      for (var i = 0; i < jsonData['list'].length; i += 8) {
        final forecastItem = jsonData['list'][i];

        final temperature = (forecastItem['main']['temp'] - 273.15);
        final temperature2 = (forecastItem['main']['feels_like'] - 273.15);
        final humidity = forecastItem['main']['humidity'];

        final forecastMap = {
          'day': dateFormatter.format(
              DateTime.fromMillisecondsSinceEpoch(forecastItem['dt'] * 1000)),
          'temperature': temperature,
          'temperature2': temperature2,
          'humidity': humidity,
          'iconCode': forecastItem['weather'][0]['icon'],
        };

        forecastData.add(forecastMap);
      }

      return forecastData;
    } else {
      throw Exception('Failed to fetch weather forecast');
    }
  }

  // String getIconPath(String iconCode) {
  //   // Add your logic to determine the icon path based on the icon code
  //   // You can use a switch statement or if-else conditions to map the icon codes to icon paths
  //   return 'assets/images/$iconCode.png';
  // }

  Future<void> _fetchWeatherData() async {
    String flag =
        'q'; // You can change this to 'id' if you want to search by city ID
    String units = 'metric'; // You can change this to 'imperial' for Fahrenheit
    String WEATHER_API_KEY =
        '285d2f45568802d9e40df8adecc4a754'; // Replace this with your OpenWeatherMap API key
    String cityName = _searchController.text;

    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?$flag=$cityName&units=$units&appid=$WEATHER_API_KEY');

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
                    title: const Text('Search'),
                    content: TextFormField(
                      controller: _searchController,
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
                          _fetchWeatherData();
                        },
                        child: const Text(
                          'Search',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
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
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.location_on,
              size: 30,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Stack(
          children: [
            loading
                ? Container(
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
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '$_temperature°C',
                                          style: const TextStyle(
                                              fontSize: 72,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          _city,
                                          style: const TextStyle(
                                              fontSize: 24,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          '$_weatherDescription',
                                          style: const TextStyle(
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
                          height: 160,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(110, 179, 185, 245),
                            borderRadius: BorderRadius.all(
                              Radius.circular(23),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: forecastData.length,
                                itemBuilder: (context, index) {
                                  final forecastItem = forecastData[index];
                                  return WeatherTimelineItem(
                                    temperature:
                                        '${forecastItem['temperature']}',
                                    time: forecastItem['time'],
                                    imagePath: forecastItem['imagePath'],
                                  );
                                }),
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
                            items: [
                              const WeatherInfoItem(
                                title: "Today's Feel Like Temperature",
                                description:
                                    "Humidity will make you like feel 42°",
                              ),
                              const WeatherInfoItem(
                                title: 'Protect Your Skin',
                                description:
                                    'UV will be extreme. Limit sun exposure if possible',
                              ),
                              WeatherInfoItem(
                                title: 'Rise and Shine',
                                description: 'Sunrise will be at $_sunrise',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 380,
                          height: 232,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(110, 179, 185, 245),
                            borderRadius: BorderRadius.all(
                              Radius.circular(23),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 5),
                            child: ListView.builder(
                              itemCount: weatherData.length,
                              itemBuilder: (context, index) {
                                final data = weatherData[index];
                                return WeatherDayItem(
                                  day: data['day'],
                                  temperature: data['temperature'],
                                  temperature2: data['temperature2'],
                                  iconPath: 'assets/images/moon.png',
                                  iconPath2: 'assets/images/sun.png',
                                  humidity: data['humidity'],
                                );
                              },
                            ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          style: const TextStyle(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          style: const TextStyle(
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
                              const CustomWeatherInfoItem(
                                icon: Icons.sunny,
                                title: "UV index",
                                value: "Low",
                                iconColor: Color.fromARGB(255, 255, 203, 28),
                              ),
                              CustomWeatherInfoItem(
                                icon: Icons.water_drop,
                                title: 'Humidity',
                                value: '$_humidity%',
                                iconColor:
                                    const Color.fromARGB(255, 152, 218, 249),
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
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ],
        ),
      ),
    );
  }
}
