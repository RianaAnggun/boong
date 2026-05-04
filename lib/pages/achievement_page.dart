import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/user_data.dart';

class AchievementPage extends StatelessWidget {
  const AchievementPage({super.key});

  Widget badge(
    String title,
    String desc,
    String icon,
    bool unlocked,
  ) {
    return Container(
      margin:
          const EdgeInsets.only(
              bottom: 14),
      padding:
          const EdgeInsets.all(18),
      decoration:
          BoxDecoration(
        color: unlocked
            ? Colors.white
            : Colors.grey.shade200,
        borderRadius:
            BorderRadius.circular(
                24),
      ),
      child: Row(
        children: [

          Text(
            icon,
            style:
                TextStyle(
              fontSize: 36,
              color: unlocked
                  ? null
                  : Colors.grey,
            ),
          ),

          const SizedBox(
              width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style:
                      const TextStyle(
                    fontSize: 20,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                Text(desc),
              ],
            ),
          ),

          Icon(
            unlocked
                ? Icons.check_circle
                : Icons.lock,
            color: unlocked
                ? Colors.green
                : Colors.grey,
          )
        ],
      ),
    );
  }

  @override
  Widget build(
      BuildContext context) {

    int point =
        UserData.totalPoint;

    return Scaffold(
      backgroundColor:
          AppTheme.bg,
      appBar: AppBar(
        title:
            const Text(
                "Achievement"),
        centerTitle: true,
        backgroundColor:
            Colors.transparent,
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(
                18),
        child: ListView(
          children: [

            badge(
              "Pemula",
              "Capai 100 Point",
              "🥉",
              point >= 100,
            ),

            badge(
              "Pro Player",
              "Capai 500 Point",
              "🥈",
              point >= 500,
            ),

            badge(
              "Math Master",
              "Capai 1000 Point",
              "🥇",
              point >= 1000,
            ),

            badge(
              "Legend",
              "Capai 5000 Point",
              "👑",
              point >= 5000,
            ),
          ],
        ),
      ),
    );
  }
}