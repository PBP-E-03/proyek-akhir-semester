import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TabBarComponent extends StatelessWidget {
  const TabBarComponent({super.key, required this.controller});
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(
          25.0,
        ),
      ),
      child: TabBar(
        controller: controller,
        // give the indicator a decoration (color and border radius)
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(
            25.0,
          ),
          color: Colors.green,
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black,
        tabs: const [
          // first tab [you can add an icon using the icon property]
          Tab(
            text: 'Donation',
          ),

          // second tab [you can add an icon using the icon property]
          Tab(
            text: 'Transaction',
          ),
        ],
      ),
    );
  }
}
