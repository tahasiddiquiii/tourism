import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tourism/common/widgets/loader.dart';
import 'package:tourism/common/widgets/stars.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final String dataPath = 'assets/info/data.json';
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString(dataPath),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Loader());
          }

          var data = json.decode(snapshot.data!);

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                      ),
                      child: CarouselSlider(
                        items: data['bannerImages'].map<Widget>((imageUrl) {
                          return Image.network(imageUrl);
                        }).toList(),
                        carouselController: carouselController,
                        options: CarouselOptions(
                          height: 300,
                          enlargeCenterPage: false,
                          autoPlay: true,
                          aspectRatio: 1,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          viewportFraction: 2,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List<Widget>.from(
                          data['bannerImages'].map(
                            (bannerImage) {
                              return GestureDetector(
                                onTap: () => carouselController.animateToPage(
                                  data['bannerImages'].indexOf(bannerImage),
                                ),
                                child: Container(
                                  width: currentIndex ==
                                          data['bannerImages']
                                              .indexOf(bannerImage)
                                      ? 29
                                      : 12,
                                  height: 7.0,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 3.0,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: currentIndex ==
                                            data['bannerImages']
                                                .indexOf(bannerImage)
                                        ? Colors.white
                                        : Colors.grey[350],
                                  ),
                                ),
                              );
                            },
                          ),
                        ).toList(),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      bottom: 140,
                      left: 25,
                      child: IconButton(
                        icon: Image.asset(
                          'assets/icons/back.png',
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Positioned(
                      top: 0,
                      bottom: 130,
                      right: 25,
                      child: IconButton(
                        icon: const Icon(
                          CupertinoIcons.search_circle_fill,
                          color: Colors.white,
                          size: 38,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Positioned(
                      top: 130,
                      bottom: 0,
                      left: 20,
                      right: 30,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.end,
                          children: [
                            Text(
                              data['bannerTitle'],
                              textDirection: TextDirection.ltr,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 38,
                                  fontWeight: FontWeight.w600),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 38),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Stars(
                            rating: data['rating'],
                            itemSize: 30,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        data['description'],
                        style: const TextStyle(
                            fontSize: 18, color: Colors.black54),
                      ),
                      const SizedBox(height: 10),
                      for (var detail in data['details'])
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 12.0),
                                child: Icon(
                                  CupertinoIcons.circle_fill,
                                  size: 6,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(width: 18),
                              Expanded(
                                child: Text(
                                  detail,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 20),
                      const Text(
                        'Popular Treks',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23.0,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      height: 230,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: data['popularTreks'].length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.all(8.0).copyWith(right: 18),
                            child: SizedBox(
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: AspectRatio(
                                      aspectRatio: 25 / 32,
                                      child: Image.network(
                                        data['popularTreks'][index]
                                            ['thumbnail'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 40,
                                    left: 10,
                                    right: 0,
                                    child: Text(
                                      data['popularTreks'][index]['title'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    left: 10,
                                    right: 0,
                                    child: Stars(
                                      rating: data['rating'],
                                      itemSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 400,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
