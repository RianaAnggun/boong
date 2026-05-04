import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/user_data.dart';

class DailyQuestPage extends StatefulWidget {
  const DailyQuestPage({super.key});

  @override
  State<DailyQuestPage> createState() =>
      _DailyQuestPageState();
}

class _DailyQuestPageState
    extends State<DailyQuestPage> {

  bool claimed = false;

  Widget questCard(
    String title,
    String desc,
    int reward,
  ) {
    return Container(
      margin:
          const EdgeInsets.only(
              bottom: 14),
      padding:
          const EdgeInsets.all(18),
      decoration:
          BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(
                24),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          Text(
            title,
            style:
                const TextStyle(
              fontSize: 22,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
              height: 6),

          Text(desc),

          const SizedBox(
              height: 14),

          SizedBox(
            width:
                double.infinity,
            child:
                ElevatedButton(
              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    claimed
                        ? Colors.grey
                        : AppTheme.blue,
              ),
              onPressed:
                  claimed
                      ? null
                      : () async {
                          UserData
                              .diamond += reward;

                          await UserData
                              .saveData();

                          setState(
                              () {
                            claimed =
                                true;
                          });
                        },
              child: Text(
                claimed
                    ? "Claimed"
                    : "Claim $reward 💎",
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(
      BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppTheme.bg,
      appBar: AppBar(
        title:
            const Text(
                "Daily Quest"),
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

            questCard(
              "Main 1 Quiz",
              "Selesaikan quiz hari ini",
              3,
            ),

            questCard(
              "Dapat 100 Point",
              "Kumpulkan point hari ini",
              5,
            ),

            questCard(
              "Login Hari Ini",
              "Masuk ke game hari ini",
              2,
            ),
          ],
        ),
      ),
    );
  }
}