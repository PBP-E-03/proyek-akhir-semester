import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key, required this.name, required this.email});
  final String name;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(email)
              ],
            ),
            const CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(
                  "https://desainkaosmurah.com/files/image/img_user/user_1/20200113115926_cartoon_park_forest_2.jpg"),
            )
          ],
        ),
      ),
    );
  }
}
