import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/user_data.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() =>
      _ProgressPageState();
}

class _ProgressPageState
    extends State<ProgressPage>
    with TickerProviderStateMixin {

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

    loadRealtime();
  }

  Future<void> loadRealtime() async {
    await UserData.loadData();

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    glow.dispose();
    super.dispose();
  }

  Widget topCard(
    int level,
    int xp,
  ) {
    return AnimatedBuilder(
      animation: glow,
      builder: (_, __) {
        return Container(
          width:
              double.infinity,
          padding:
              const EdgeInsets.all(
                  24),
          decoration:
              BoxDecoration(
            borderRadius:
                BorderRadius.circular(
                    30),
            gradient:
                const LinearGradient(
              begin:
                  Alignment.topLeft,
              end:
                  Alignment.bottomRight,
              colors: [
                Color(0xff7F00FF),
                Color(0xff00C6FF),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blue
                    .withOpacity(
                        .18 +
                            glow.value *
                                .15),
                blurRadius: 22,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment
                    .start,
            children: [

              Row(
                children: [

                  const CircleAvatar(
                    radius: 26,
                    backgroundColor:
                        Colors.white24,
                    child: Icon(
                      Icons
                          .workspace_premium,
                      color:
                          Colors.amber,
                    ),
                  ),

                  const SizedBox(
                      width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                      children: [

                        Text(
                          "LEVEL $level",
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

                        const Text(
                          "Math Warrior",
                          style:
                              TextStyle(
                            color: Colors
                                .white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(
                  height: 20),

              Text(
                "$xp / 100 XP",
                style:
                    const TextStyle(
                  color:
                      Colors.white70,
                ),
              ),

              const SizedBox(
                  height: 10),

              ClipRRect(
                borderRadius:
                    BorderRadius.circular(
                        20),
                child:
                    LinearProgressIndicator(
                  minHeight: 12,
                  value:
                      xp / 100,
                  backgroundColor:
                      Colors.white24,
                  valueColor:
                      const AlwaysStoppedAnimation(
                    Colors.amber,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget statBox(
    String title,
    String value,
    IconData icon,
    List<Color> colors,
  ) {
    return Container(
      padding:
          const EdgeInsets.all(
              18),
      decoration:
          BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(
                24),
        boxShadow: [
          BoxShadow(
            color: colors.first
                .withOpacity(.12),
            blurRadius: 14,
          ),
        ],
      ),
      child: Column(
        children: [

          Container(
            padding:
                const EdgeInsets
                    .all(12),
            decoration:
                BoxDecoration(
              shape:
                  BoxShape.circle,
              gradient:
                  LinearGradient(
                colors: colors,
              ),
            ),
            child: Icon(
              icon,
              color:
                  Colors.white,
            ),
          ),

          const SizedBox(
              height: 12),

          Text(
            value,
            style:
                const TextStyle(
              fontSize: 26,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
              height: 4),

          Text(
            title,
            style:
                const TextStyle(
              color:
                  Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget performanceCard() {
    List<int> scores =
        List.from(
            UserData.quizHistory);

    if (scores.isEmpty) {
      return Container(
        width:
            double.infinity,
        padding:
            const EdgeInsets.all(
                20),
        decoration:
            BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(
                  28),
        ),
        child: const Text(
          "Belum ada data quiz.",
          style: TextStyle(
              fontSize: 18),
        ),
      );
    }

    int last = scores.last;

    String rank = "C";
    String title =
        "Keep Trying";
    String desc =
        "Terus latihan, kamu pasti berkembang 🚀";
    Color color =
        Colors.orange;
    IconData icon =
        Icons.auto_awesome;

    if (last >= 90) {
      rank = "S";
      title =
          "Legend Math";
      desc =
          "Performa luar biasa! Kamu di level tertinggi 🔥";
      color =
          Colors.amber;
      icon = Icons
          .workspace_premium;
    } else if (last >= 75) {
      rank = "A";
      title =
          "Great Player";
      desc =
          "Hebat! Kemampuan berhitungmu sangat bagus 💪";
      color =
          Colors.green;
      icon = Icons
          .emoji_events;
    } else if (last >= 60) {
      rank = "B";
      title =
          "Good Progress";
      desc =
          "Bagus, terus latihan agar naik rank 🎯";
      color =
          Colors.blue;
      icon = Icons
          .trending_up;
    }

    return Container(
      width:
          double.infinity,
      padding:
          const EdgeInsets.all(
              22),
      decoration:
          BoxDecoration(
        borderRadius:
            BorderRadius.circular(
                28),
        gradient:
            LinearGradient(
          colors: [
            color.withOpacity(
                .9),
            color,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: color
                .withOpacity(
                    .25),
            blurRadius: 18,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment
                .start,
        children: [

          Row(
            children: [

              CircleAvatar(
                radius: 26,
                backgroundColor:
                    Colors.white24,
                child: Icon(
                  icon,
                  color: Colors
                      .white,
                ),
              ),

              const SizedBox(
                  width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [

                    Text(
                      "RANK $rank",
                      style:
                          const TextStyle(
                        color: Colors
                            .white70,
                        fontSize:
                            14,
                      ),
                    ),

                    Text(
                      title,
                      style:
                          const TextStyle(
                        color: Colors
                            .white,
                        fontSize:
                            24,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                "$last",
                style:
                    const TextStyle(
                  color:
                      Colors.white,
                  fontSize: 34,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(
              height: 18),

          Text(
            desc,
            style:
                const TextStyle(
              color:
                  Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget chartCard() {
    List<int> scores =
        List.from(
            UserData.quizHistory);

    if (scores.isEmpty) {
      return Container(
        padding:
            const EdgeInsets.all(
                20),
        decoration:
            BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(
                  28),
        ),
        child: const Center(
          child: Text(
            "Belum ada riwayat quiz",
            style: TextStyle(
                fontSize: 18),
          ),
        ),
      );
    }

    int max = scores.reduce(
      (a, b) =>
          a > b ? a : b,
    );

    return Container(
      padding:
          const EdgeInsets.all(
              20),
      decoration:
          BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(
                28),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment
                .start,
        children: [

          const Text(
            "📈 Score Progress",
            style: TextStyle(
              fontSize: 22,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
              height: 22),

          SizedBox(
            height: 220,
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.end,
              children: scores
                  .asMap()
                  .entries
                  .map((e) {

                double h =
                    (e.value /
                            max) *
                        170;

                return Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(
                            horizontal:
                                4),
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.end,
                      children: [

                        Text(
                          "${e.value}",
                          style:
                              const TextStyle(
                            fontWeight:
                                FontWeight.bold,
                            fontSize:
                                12,
                          ),
                        ),

                        const SizedBox(
                            height:
                                6),

                        AnimatedContainer(
                          duration:
                              Duration(
                            milliseconds:
                                500 +
                                    e.key *
                                        100,
                          ),
                          height: h,
                          decoration:
                              BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(
                                    14),
                            gradient:
                                const LinearGradient(
                              begin:
                                  Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(
                                    0xff7F00FF),
                                Color(
                                    0xff00C6FF),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(
                            height:
                                8),

                        Text(
                          "Q${e.key + 1}",
                          style:
                              const TextStyle(
                            fontSize:
                                12,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget skillBar(
    String title,
    int value,
    Color color,
    IconData icon,
  ) {
    return Container(
      margin:
          const EdgeInsets.only(
              bottom: 14),
      padding:
          const EdgeInsets.all(
              18),
      decoration:
          BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(
                24),
      ),
      child: Column(
        children: [

          Row(
            children: [

              Icon(
                icon,
                color: color,
              ),

              const SizedBox(
                  width: 10),

              Expanded(
                child: Text(
                  title,
                  style:
                      const TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),

              Text(
                "$value%",
                style:
                    TextStyle(
                  color: color,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(
              height: 12),

          ClipRRect(
            borderRadius:
                BorderRadius.circular(
                    20),
            child:
                LinearProgressIndicator(
              minHeight: 10,
              value: value / 100,
              backgroundColor:
                  Colors.grey.shade200,
              valueColor:
                  AlwaysStoppedAnimation(
                color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(
      BuildContext context) {

    int level =
        (UserData.totalPoint ~/
                100) +
            1;

    int xp =
        UserData.totalPoint %
            100;

    return Scaffold(
      backgroundColor:
          AppTheme.bg,

      body: SafeArea(
        child:
            RefreshIndicator(
          onRefresh:
              loadRealtime,
          child:
              SingleChildScrollView(
            physics:
                const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding:
                  const EdgeInsets
                      .all(18),
              child: Column(
                children: [

                  Row(
                    children: [

                      GestureDetector(
                        onTap: () {
                          Navigator.pop(
                              context);
                        },
                        child: Container(
                          width: 46,
                          height: 46,
                          decoration:
                              BoxDecoration(
                            color:
                                Colors.white,
                            borderRadius:
                                BorderRadius.circular(
                                    16),
                          ),
                          child:
                              const Icon(
                            Icons
                                .arrow_back_ios_new,
                            size: 18,
                          ),
                        ),
                      ),

                      const Expanded(
                        child: Center(
                          child: Text(
                            "My Progress",
                            style:
                                TextStyle(
                              fontSize:
                                  28,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                          width: 46),
                    ],
                  ),

                  const SizedBox(
                      height: 20),

                  topCard(
                    level,
                    xp,
                  ),

                  const SizedBox(
                      height: 18),

                  GridView.count(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(),
                    crossAxisCount:
                        2,
                    crossAxisSpacing:
                        14,
                    mainAxisSpacing:
                        14,
                    childAspectRatio:
                        1.15,
                    children: [

                      statBox(
                        "Point",
                        "${UserData.totalPoint}",
                        Icons.star,
                        [
                          Colors.orange,
                          Colors.deepOrange,
                        ],
                      ),

                      statBox(
                        "Diamond",
                        "${UserData.diamond}",
                        Icons.diamond,
                        [
                          Colors.blue,
                          Colors.cyan,
                        ],
                      ),

                      statBox(
                        "Energy",
                        "${UserData.energy}",
                        Icons.flash_on,
                        [
                          Colors.green,
                          Colors.teal,
                        ],
                      ),

                      statBox(
                        "Quiz",
                        "${UserData.quizHistory.length}",
                        Icons.quiz,
                        [
                          Colors.purple,
                          Colors.deepPurple,
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(
                      height: 18),

                  performanceCard(),

                  const SizedBox(
                      height: 18),

                  chartCard(),

                  const SizedBox(
                      height: 18),

                  Align(
                    alignment:
                        Alignment
                            .centerLeft,
                    child: Text(
                      "📘 Skill Mastery",
                      style:
                          TextStyle(
                        fontSize:
                            24,
                        fontWeight:
                            FontWeight.bold,
                        color:
                            AppTheme.dark,
                      ),
                    ),
                  ),

                  const SizedBox(
                      height: 14),

                  skillBar(
                    "Penjumlahan",
                    UserData
                        .addProgress,
                    Colors.blue,
                    Icons.add,
                  ),

                  skillBar(
                    "Pengurangan",
                    UserData
                        .subProgress,
                    Colors.green,
                    Icons.remove,
                  ),

                  skillBar(
                    "Perkalian",
                    UserData
                        .mulProgress,
                    Colors.orange,
                    Icons.close,
                  ),

                  const SizedBox(
                      height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}