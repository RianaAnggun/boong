import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/user_data.dart';

class LoginRewardPage extends StatefulWidget {
  const LoginRewardPage({super.key});

  @override
  State<LoginRewardPage> createState() =>
      _LoginRewardPageState();
}

class _LoginRewardPageState
    extends State<LoginRewardPage>
    with TickerProviderStateMixin {

  final DateTime now = DateTime.now();

  late AnimationController glow;

  @override
  void initState() {
    super.initState();

    glow = AnimationController(
      vsync: this,
      duration:
          const Duration(
              seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    glow.dispose();
    super.dispose();
  }

  bool claimedToday() {
    return UserData.lastRewardDate ==
        "${now.day}-${now.month}-${now.year}";
  }

  Future<void> claimToday() async {
    if (claimedToday()) return;

    int reward =
        now.day * 10;

    UserData.totalPoint +=
        reward;

    if (now.day % 7 == 0) {
      UserData.diamond += 5;
    }

    UserData.lastRewardDate =
        "${now.day}-${now.month}-${now.year}";

    await UserData.saveData();

    setState(() {});

    showDialog(
      context: context,
      builder: (_) =>
          AlertDialog(
        shape:
            RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(
                  24),
        ),
        title:
            const Text(
                "🎉 Reward"),
        content: Text(
          "+$reward Point",
          textAlign:
              TextAlign.center,
          style:
              const TextStyle(
            fontSize: 26,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),
    );
  }

  String iconReward(int day) {
    if (day % 7 == 0) return "💎";
    if (day % 5 == 0) return "⚡";
    if (day % 3 == 0) return "🎁";
    return "⭐";
  }

  Color colorReward(int day) {
    if (day % 7 == 0) return Colors.blue;
    if (day % 5 == 0) return Colors.orange;
    if (day % 3 == 0) return Colors.purple;
    return Colors.green;
  }

  Widget dayBox(int day) {
    bool today =
        day == now.day;

    bool claimed =
        today &&
            claimedToday();

    Color color =
        colorReward(day);

    return AnimatedBuilder(
      animation: glow,
      builder: (_, __) {
        return GestureDetector(
          onTap:
              today
                  ? claimToday
                  : null,
          child:
              AnimatedContainer(
            duration:
                const Duration(
                    milliseconds:
                        250),
            decoration:
                BoxDecoration(
              gradient: today
                  ? LinearGradient(
                      colors: [
                        color,
                        color.withOpacity(
                            .7),
                      ],
                    )
                  : null,
              color: !today
                  ? Colors.white
                  : null,
              borderRadius:
                  BorderRadius.circular(
                      18),
              boxShadow: [
                BoxShadow(
                  color: today
                      ? color.withOpacity(
                          .18 +
                              glow.value *
                                  .18)
                      : Colors.black12,
                  blurRadius:
                      today
                          ? 14
                          : 5,
                )
              ],
            ),
            child: Padding(
              padding:
                  const EdgeInsets
                      .all(4),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment
                        .center,
                children: [

                  Text(
                    iconReward(day),
                    style:
                        const TextStyle(
                      fontSize:
                          15,
                    ),
                  ),

                  const SizedBox(
                      height:
                          2),

                  Text(
                    "$day",
                    style:
                        TextStyle(
                      fontSize:
                          13,
                      fontWeight:
                          FontWeight.bold,
                      color: today
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),

                  if (today)
                    Text(
                      claimed
                          ? "CLAIMED"
                          : "CLAIM",
                      style:
                          const TextStyle(
                        fontSize:
                            7,
                        color: Colors
                            .white,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget infoCard() {
    return Container(
      width:
          double.infinity,
      padding:
          const EdgeInsets.all(
              16),
      decoration:
          BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(
                22),
      ),
      child: const Column(
        children: [

          Text(
            "🎁 Reward Info",
            style: TextStyle(
              fontSize: 22,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          SizedBox(height: 12),

          Text("⭐ Point"),
          Text("🎁 Surprise Box"),
          Text("⚡ Energy"),
          Text("💎 Diamond"),
        ],
      ),
    );
  }

  @override
  Widget build(
      BuildContext context) {

    int totalDays =
        DateUtils
            .getDaysInMonth(
      now.year,
      now.month,
    );

    return Scaffold(
      backgroundColor:
          AppTheme.bg,

      appBar: AppBar(
        title:
            const Text(
                "Login Reward"),
        centerTitle: true,
        backgroundColor:
            Colors.transparent,
      ),

      body: SafeArea(
        child:
            SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets
                    .all(16),
            child: Column(
              children: [

                Container(
                  width:
                      double.infinity,
                  padding:
                      const EdgeInsets
                          .all(20),
                  decoration:
                      BoxDecoration(
                    gradient:
                        const LinearGradient(
                      colors: [
                        Color(
                            0xffFF9966),
                        Color(
                            0xffFF5E62),
                      ],
                    ),
                    borderRadius:
                        BorderRadius.circular(
                            26),
                  ),
                  child: Column(
                    children: [

                      const Icon(
                        Icons
                            .card_giftcard,
                        color: Colors
                            .white,
                        size: 42,
                      ),

                      const SizedBox(
                          height:
                              8),

                      Text(
                        "${now.month}/${now.year}",
                        style:
                            const TextStyle(
                          fontSize:
                              28,
                          color: Colors
                              .white,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                          height:
                              4),

                      Text(
                        claimedToday()
                            ? "Reward claimed 🎉"
                            : "Claim Day ${now.day}",
                        style:
                            const TextStyle(
                          color: Colors
                              .white70,
                          fontSize:
                              12,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                    height: 18),

                GridView.builder(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(),
                  itemCount:
                      totalDays,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        7,
                    crossAxisSpacing:
                        6,
                    mainAxisSpacing:
                        6,
                    childAspectRatio:
                        0.72,
                  ),
                  itemBuilder:
                      (_, index) {
                    return dayBox(
                        index + 1);
                  },
                ),

                const SizedBox(
                    height: 20),

                infoCard(),

                const SizedBox(
                    height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}