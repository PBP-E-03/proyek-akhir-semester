import 'package:flutter/material.dart';
import 'package:rounded_expansion_tile/rounded_expansion_tile.dart';

class FAQTile extends StatelessWidget {
  const FAQTile({super.key, required this.title, required this.contents});

  final String title;
  final List<Widget> contents;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      color: Colors.white,
      child: RoundedExpansionTile(
        childrenPadding: const EdgeInsets.all(18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        duration: const Duration(milliseconds: 150),
        trailing: const Icon(Icons.add, color: Colors.green),
        rotateTrailing: false,
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        children: contents,
      ),
    );
  }
}
