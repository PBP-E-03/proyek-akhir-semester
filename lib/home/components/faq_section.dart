import 'package:flutter/material.dart';
import 'package:pbp_e_03_flutter/home/components/faq_tile.dart';
import 'package:rounded_expansion_tile/rounded_expansion_tile.dart';

class FAQ {
  FAQ(this.title, this.body, [this.isExpanded = false]);
  String title;
  String body;
  bool isExpanded;
}

List<FAQ> getFAQs() {
  return [
    FAQ('How to donate a tree in GenerosiTree?',
        "It's simple, you just have to go to donation screen by clicking on the \"Donate\" button in the home screen or in the navigation bar. Then, fill up your data and desired donation amount. Fulfill the payment and Voila! Your donation is on the way."),
    FAQ('How can i got the coin?',
        'You will got the coin when you donate the trees in GenerosiTree. Coin will be granted to you based on the amount of tree donated.'),
    FAQ('What can i do with the coin?',
        "You may use the coin to buy many interesting items in the GenerosiTree market. The item will be send to your address."),
    FAQ("What is Leaderboard?",
        "Leaderboard will show the rank of GenerosiTree's user based on the number of trees they're donated on each country."),
  ];
}

class FAQSection extends StatefulWidget {
  const FAQSection({super.key});

  @override
  State<FAQSection> createState() => _FAQSectionState();
}

class _FAQSectionState extends State<FAQSection> {
  final List<FAQ> _faqs = getFAQs();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "FAQ",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
            children: _faqs
                .map((faq) =>
                    FAQTile(title: faq.title, contents: [Text(faq.body)]))
                .toList()),
      ],
    );
  }
}
