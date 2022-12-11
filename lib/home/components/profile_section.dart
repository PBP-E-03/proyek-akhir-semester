import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: const [
            CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(
                  "https://desainkaosmurah.com/files/image/img_user/user_1/20200113115926_cartoon_park_forest_2.jpg"),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Adjie Djaka Permana",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ],
        ),
        TextButton(
          onPressed: () {},
          child: const Icon(Icons.menu),
        )
      ],
    );
  }
}
