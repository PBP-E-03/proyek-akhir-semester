import 'package:flutter/material.dart';
import 'package:pbp_e_03_flutter/profile/screens/profile_screen.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key, required this.name, required this.coin});
  final String name;
  final int coin;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(
                  "https://desainkaosmurah.com/files/image/img_user/user_1/20200113115926_cartoon_park_forest_2.jpg"),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.monetization_on,
                      color: Colors.orange,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text("$coin")
                  ],
                )
              ],
            )
          ],
        ),
        TextButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()));
          },
          child: const Icon(Icons.menu),
        )
      ],
    );
  }
}
