import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 43, 64, 81),
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
      ),
      body: SingleChildScrollView(
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
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '29°',
                                    style: TextStyle(
                                      fontSize: 65,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'Karachi',
                                    style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    '35° / 28° Feels like 36°',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'Sun, 12:46 Am',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  )
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
                        SizedBox(
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
                              horizontal: 15, vertical: 15),
                          child: Stack(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      const Text(
                                        '1 am',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Image.asset(
                                        "assets/images/Icon.png",
                                        height: 20,
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      const Text(
                                        '29°',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        '2 am',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Image.asset(
                                        "assets/images/Icon.png",
                                        height: 20,
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      const Text(
                                        '29°',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        '3 am',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Image.asset(
                                        "assets/images/Icon.png",
                                        height: 20,
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      const Text(
                                        '29°',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        '4 am',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Image.asset(
                                        "assets/images/Icon.png",
                                        height: 20,
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      const Text(
                                        '29°',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        '5 am',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Image.asset(
                                        "assets/images/Icon.png",
                                        height: 20,
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      const Text(
                                        '29°',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        '6 am',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Image.asset(
                                        "assets/images/Icon.png",
                                        height: 20,
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      const Text(
                                        '29°',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        '7 am',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Image.asset(
                                        "assets/images/Icon.png",
                                        height: 20,
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      const Text(
                                        '29°',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        '8 am',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Image.asset(
                                        "assets/images/Icon.png",
                                        height: 20,
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      const Text(
                                        '29°',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        '9 am',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Image.asset(
                                        "assets/images/Icon.png",
                                        height: 20,
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      const Text(
                                        '29°',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        '10 am',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Image.asset(
                                        "assets/images/Icon.png",
                                        height: 20,
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      const Text(
                                        '29°',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        '11 am',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Image.asset(
                                        "assets/images/Icon.png",
                                        height: 20,
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      const Text(
                                        '29°',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        '12 pm',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Image.asset(
                                        "assets/images/Icon.png",
                                        height: 20,
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      const Text(
                                        '29°',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
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
                    padding: EdgeInsets.only(top: 20),
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
                        Column(
                          children: [
                            Text(
                              "Today's Feel Like Temperature",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "Humidity will make you feel like 42°",
                              style: TextStyle(
                                color: Color.fromARGB(255, 181, 179, 179),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Protect your Skin",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "UC will be extreme.Limit sun exposure if possible",
                              style: TextStyle(
                                color: Color.fromARGB(255, 181, 179, 179),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Rise and shine",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "Sunrise will be at 5:41 am",
                              style: TextStyle(
                                color: Color.fromARGB(255, 181, 179, 179),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 200,
                    color: Colors.black,
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
