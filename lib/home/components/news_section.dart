import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final List<Map<String, String>> imgList = [
  {
    "imageUrl":
        'https://i0.wp.com/forestsnews.cifor.org/wp-content/uploads/2018/10/38435036161_5961bd2cb3_c-copy.jpg?resize=799%2C415&ssl=1',
    "title":
        "Inseparable in Indonesia: Forests, finance and development planning",
    "url":
        "https://forestsnews.cifor.org/79612/inseparable-in-indonesia-forests-finance-and-development-planning?fnl=en"
  },
  {
    "imageUrl":
        'https://i0.wp.com/forestsnews.cifor.org/wp-content/uploads/2018/11/Planting-tree-seedlings-at-Jishinde-ushinde-Tree-nursery-Kaluluini-Yatta-Kenya-2019-scaled.jpg?zoom=2&resize=832%2C415&ssl=1',
    "title":
        "Trees are one of our best investments against the climate crisis – but who should foot the bill?",
    "url":
        "https://forestsnews.cifor.org/79637/trees-are-one-of-our-best-investments-against-the-climate-crisis-but-who-should-foot-the-bill?fnl=en"
  },
  {
    "imageUrl":
        'https://i0.wp.com/forestsnews.cifor.org/wp-content/uploads/2022/10/35855338036_89f330abe9_c.jpg?resize=799%2C415&ssl=1',
    "title": "How to preserve forest biodiversity without losing livelihoods",
    "url":
        "https://forestsnews.cifor.org/79379/how-to-preserve-forest-biodiversity-without-losing-livelihoods?fnl=en"
  },
  {
    "imageUrl":
        'https://i0.wp.com/forestsnews.cifor.org/wp-content/uploads/2022/06/Three-years-old-nyamplung-on-degraded-peatland-Photo-CIFOR-Himlal-Baral.jpeg?resize=832%2C415&ssl=1',
    "title": "How bioenergy can help restore landscapes and livelihoods",
    "url":
        "https://forestsnews.cifor.org/78013/how-bioenergy-can-help-restore-landscapes-and-livelihoods-2?fnl="
  },
  {
    "imageUrl":
        'https://i0.wp.com/forestsnews.cifor.org/wp-content/uploads/2022/05/35781446921_db0b200cd8_c.jpg?resize=800%2C415&ssl=1',
    "title":
        "Q+A: Amazon expert Manuel Guariguata reacts to State of the World’s Forests report",
    "url":
        "https://forestsnews.cifor.org/77269/qa-amazon-expert-manuel-guariguata-reacts-to-state-of-the-worlds-forests-report?fnl="
  }
];

class NewsSection extends StatelessWidget {
  NewsSection({super.key});

  final List<Widget> imageSliders = imgList
      .map((item) => GestureDetector(
            onTap: () async {
              Uri url = Uri.parse(item['url']!);
              if (!await launchUrl(url)) {
                throw 'Could not launch $url';
              }
            },
            child: Container(
              margin: const EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(
                        item['imageUrl']!,
                        fit: BoxFit.cover,
                        width: 1000.0,
                        height: 1000.0,
                      ),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          height: 70,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            item['title']!,
                            maxLines: 2,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text(
        "News",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      const SizedBox(
        height: 10,
      ),
      CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 2.0,
        ),
        items: imageSliders,
      )
    ]);
  }
}
