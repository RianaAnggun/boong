import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/user_data.dart';
import 'leaderboard_page.dart';
import 'level_page.dart';
import 'profile_page.dart';
import 'store_page.dart';
import 'spin_page.dart';
import 'login_reward_page.dart';
import 'achievement_page.dart';
import 'daily_quest_page.dart';
import 'progress_page.dart';
import 'ai_chat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() =>
      _HomePageState();
}

class _HomePageState
    extends State<HomePage> {
      @override
void initState() {
  super.initState();
  refreshData();
}

Future<void> refreshData() async {
  await UserData.loadData();

  if (!mounted) return;

  setState(() {});
}

  Widget categoryCard({
  required Color color,
  required String title,
  required String subtitle,
  required int progress,
  required IconData icon,
}) {
  String rank = "Bronze";
  Color rankColor = Colors.brown;
  bool locked = false;

  if (title == "Pengurangan" &&
      UserData.addProgress < 30) {
    locked = true;
  }

  if (title == "Perkalian" &&
      UserData.subProgress < 30) {
    locked = true;
  }

  if (progress >= 100) {
    rank = "Master";
    rankColor = Colors.purple;
  } else if (progress >= 75) {
    rank = "Platinum";
    rankColor = Colors.blue;
  } else if (progress >= 50) {
    rank = "Gold";
    rankColor = Colors.amber;
  } else if (progress >= 25) {
    rank = "Silver";
    rankColor = Colors.grey;
  }

  return AnimatedContainer(
    duration:
        const Duration(
            milliseconds: 500),
    margin:
        const EdgeInsets.only(
            bottom: 18),
    padding:
        const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color:
          locked
              ? Colors.grey.shade200
              : Colors.white,
      borderRadius:
          BorderRadius.circular(
              28),
      boxShadow: [
        BoxShadow(
          color: locked
              ? Colors.black12
              : color.withOpacity(.18),
          blurRadius: 14,
          offset:
              const Offset(0, 8),
        )
      ],
    ),
    child: Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [

        Row(
          children: [

            CircleAvatar(
              radius: 28,
              backgroundColor:
                  locked
                      ? Colors.grey
                      : color
                          .withOpacity(
                              .15),
              child: Icon(
                locked
                    ? Icons.lock
                    : icon,
                color: locked
                    ? Colors.white
                    : color,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Text(
                title,
                style:
                    TextStyle(
                  fontSize: 26,
                  fontWeight:
                      FontWeight.bold,
                  color: locked
                      ? Colors.grey
                      : Colors.black,
                ),
              ),
            ),

            Container(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: rankColor,
                borderRadius:
                    BorderRadius.circular(
                        20),
                boxShadow: [
                  BoxShadow(
                    color: rankColor
                        .withOpacity(
                            .35),
                    blurRadius: 10,
                  )
                ],
              ),
              child: Text(
                rank,
                style:
                    const TextStyle(
                  color: Colors.white,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 14),

        Text(
          locked
              ? "Selesaikan kategori sebelumnya untuk membuka."
              : subtitle,
          style: TextStyle(
            color:
                Colors.grey.shade600,
          ),
        ),

        const SizedBox(height: 18),

        Row(
          mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,
          children: [
            const Text(
              "PROGRESS",
              style: TextStyle(
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            Text(
              locked
                  ? "LOCKED"
                  : "$progress%",
            ),
          ],
        ),

        const SizedBox(height: 10),

        TweenAnimationBuilder(
          tween: Tween<double>(
            begin: 0,
            end: locked
                ? 0
                : progress / 100,
          ),
          duration:
              const Duration(
                  milliseconds:
                      1000),
          builder:
              (context, value, child) {
            return ClipRRect(
              borderRadius:
                  BorderRadius.circular(
                      20),
              child:
                  LinearProgressIndicator(
                minHeight: 12,
                value: value,
                color:
                    locked
                        ? Colors.grey
                        : color,
                backgroundColor:
                    Colors.grey
                        .shade200,
              ),
            );
          },
        ),

        if (progress >= 100 &&
            !locked)
          Padding(
            padding:
                const EdgeInsets.only(
                    top: 14),
            child: Row(
              children: const [
                Icon(
                  Icons.star,
                  color:
                      Colors.amber,
                ),
                SizedBox(width: 6),
                Text(
                  "Reward Unlocked!",
                  style:
                      TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
      ],
    ),
  );
}
  Widget premiumMenuButton({
    required String title,
    required String subtitle,
    required IconData icon,
    required List<Color> colors,
    required VoidCallback onTap,
  }) {
    return Container(
      margin:
          const EdgeInsets.only(
              bottom: 18),
      decoration:
          BoxDecoration(
        borderRadius:
            BorderRadius.circular(
                28),
        boxShadow: [
          BoxShadow(
            color: colors.first
                .withOpacity(.35),
            blurRadius: 18,
            offset:
                const Offset(0, 10),
          ),
        ],
        gradient:
            LinearGradient(
          begin:
              Alignment.topLeft,
          end: Alignment
              .bottomRight,
          colors: colors,
        ),
      ),
      child: Material(
        color:
            Colors.transparent,
        child: InkWell(
          borderRadius:
              BorderRadius
                  .circular(28),
          splashColor:
              Colors.white24,
          onTap: onTap,
          child: Padding(
            padding:
                const EdgeInsets
                    .all(20),
            child: Row(
              children: [

                Container(
                  padding:
                      const EdgeInsets
                          .all(14),
                  decoration:
                      BoxDecoration(
                    color: Colors
                        .white
                        .withOpacity(
                            .18),
                    shape: BoxShape
                        .circle,
                  ),
                  child: Icon(
                    icon,
                    color: Colors
                        .white,
                    size: 30,
                  ),
                ),

                const SizedBox(
                    width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                    children: [

                      Text(
                        title,
                        style:
                            const TextStyle(
                          color: Colors
                              .white,
                          fontSize:
                              24,
                          fontWeight:
                              FontWeight
                                  .bold,
                        ),
                      ),

                      const SizedBox(
                          height:
                              6),

                      Text(
                        subtitle,
                        style:
                            const TextStyle(
                          color: Colors
                              .white70,
                          fontSize:
                              15,
                        ),
                      ),
                    ],
                  ),
                ),

                const Icon(
                  Icons
                      .arrow_forward_ios,
                  color:
                      Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(
      BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppTheme.bg,

      bottomNavigationBar:
          BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor:
            AppTheme.blue,
        unselectedItemColor:
            Colors.grey,
        onTap: (i) async {
  if (i == 1) {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LeaderboardPage(),
      ),
    );

    refreshData();
  }

  if (i == 2) {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ProfilePage(),
      ),
    );

    refreshData();
  }
},
        items: const [
          BottomNavigationBarItem(
            icon:
                Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons
                .leaderboard),
            label: "Rank",
          ),
          BottomNavigationBarItem(
            icon: Icon(
                Icons.person),
            label: "Profil",
          ),
        ],
      ),

      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.all(
                  18),
          child: ListView(
            children: [

              Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                children: [

                  Text(
                    "MATHRUSH",
                    style:
                        TextStyle(
                      fontSize:
                          30,
                      fontWeight:
                          FontWeight
                              .bold,
                      color:
                          AppTheme
                              .blue,
                    ),
                  ),

                  const CircleAvatar(
                    radius: 24,
                    child: Icon(
                        Icons.person),
                  ),
                ],
              ),

              const SizedBox(
                  height: 28),

              Text(
                "Halo,\n${UserData.username}",
                style:
                    TextStyle(
                  fontSize: 46,
                  height: 1,
                  fontWeight:
                      FontWeight.bold,
                  color:
                      AppTheme.dark,
                ),
              ),

              const SizedBox(
                  height: 14),

              const Text(
                "Ayo lanjutkan latihan matematika hari ini 🚀",
                style: TextStyle(
                    fontSize: 18),
              ),

              const SizedBox(
                  height: 26),

              Container(
                padding:
                    const EdgeInsets
                        .all(22),
                decoration:
                    BoxDecoration(
                  color:
                      AppTheme.blue,
                  borderRadius:
                      BorderRadius
                          .circular(
                              30),
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [

                    const Text(
                      "TOTAL POIN",
                      style:
                          TextStyle(
                        color: Colors
                            .white70,
                        letterSpacing:
                            2,
                      ),
                    ),

                    const SizedBox(
                        height: 10),

                    Text(
                      "${UserData.totalPoint}",
                      style:
                          const TextStyle(
                        color: Colors
                            .white,
                        fontSize:
                            42,
                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                  height: 28),
                  Row(
  children: [

    Expanded(
      child: Container(
        padding:
            const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(
                  24),
        ),
        child: Column(
          children: [

            const Icon(
              Icons.bolt,
              color: Colors.orange,
              size: 34,
            ),

            const SizedBox(height: 8),

            Text(
              "${UserData.energy}/5",
              style:
                  const TextStyle(
                fontSize: 24,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const Text("ENERGY"),
          ],
        ),
      ),
    ),

    const SizedBox(width: 14),

    Expanded(
      child: Container(
        padding:
            const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(
                  24),
        ),
        child: Column(
          children: [

            const Icon(
              Icons.diamond,
              color: Colors.blue,
              size: 34,
            ),

            const SizedBox(height: 8),

            Text(
              "${UserData.diamond}",
              style:
                  const TextStyle(
                fontSize: 24,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const Text("DIAMOND"),
          ],
        ),
      ),
    ),
  ],
),

              premiumMenuButton(
                
                title:
                    "Lanjutkan Petualangan",
                subtitle:
                    "Pilih level dan mulai kuis",
                icon: Icons
                    .rocket_launch,
                colors: [
                  const Color(
                      0xff2F80ED),
                  const Color(
                      0xff56CCF2),
                ],
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const LevelPage(),
                    ),
                  );
                  refreshData();
                },
              ),

              premiumMenuButton(
                title:
                    "Leaderboard",
                subtitle:
                    "Lihat ranking pemain",
                icon: Icons
                    .emoji_events,
                colors: [
                  const Color(
                      0xffF2994A),
                  const Color(
                      0xffF2C94C),
                ],
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          LeaderboardPage(),
                    ),
                  );
                  refreshData();
                },
              ),

              const SizedBox(
                  height: 10),

              const Text(
                "Kategori",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(
                  height: 18),

              categoryCard(
                color: Colors.blue,
                title:
                    "Penjumlahan",
                subtitle:
                    "Latihan tambah cepat.",
                progress: UserData.addProgress,
                icon: Icons.add,
              ),

              categoryCard(
                color:
                    Colors.green,
                title:
                    "Pengurangan",
                subtitle:
                    "Kurangi angka dengan tepat.",
                progress: UserData.subProgress,
                icon: Icons
                    .remove,
              ),

              categoryCard(
                color:
                    Colors.orange,
                title:
                    "Perkalian",
                subtitle:
                    "Tingkatkan logika hitung.",
                progress: UserData.mulProgress,
                icon:
                    Icons.close,
              ),

              const SizedBox(
                  height: 30),

                  premiumMenuButton(
  title: "Daily Reward",
  subtitle:
      UserData.dailyClaimed
          ? "Sudah diklaim hari ini"
          : "Claim +50 poin +5 diamond",
  icon: Icons.card_giftcard,
  colors: [
    Colors.purple,
    Colors.deepPurpleAccent,
  ],
  onTap: () async {

    if (!UserData.dailyClaimed) {

      UserData.totalPoint += 50;
      UserData.diamond += 5;
      UserData.dailyClaimed = true;

      await UserData.saveData();

      setState(() {});
    }
    refreshData();
  },
),

premiumMenuButton(
  title: "Game Store",
  subtitle: "Beli energy & reward",
  icon: Icons.store,
  colors: [
    Colors.green,
    Colors.teal,
  ],
  onTap: () async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StorePage(),
      ),
    );
    refreshData();
  },
),

premiumMenuButton(
  title: "Lucky Spin",
  subtitle: "Putar hadiah harian",
  icon: Icons.casino,
  colors: [
    Colors.purple,
    Colors.deepPurple,
  ],
  onTap: () async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SpinPage(),
      ),
    );
    refreshData();
  },
),

premiumMenuButton(
  title: "Login Reward",
  subtitle: "Claim hadiah harian",
  icon: Icons.card_giftcard,
  colors: [
    Colors.pink,
    Colors.orange,
  ],
  onTap: () async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const LoginRewardPage(),
      ),
    );
    refreshData();
  },
),

premiumMenuButton(
  title: "My Progress",
  subtitle: "Lihat level, XP dan statistik",
  icon: Icons.bar_chart,
  colors: [
    const Color(0xff8E2DE2),
    const Color(0xff4A00E0),
  ],
  onTap: () async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const ProgressPage(),
      ),
    );
    refreshData();
  },
),

premiumMenuButton(
  title: "MathRush AI",
  subtitle: "Tanya soal matematika bebas",
  icon: Icons.smart_toy,
  colors: [
    const Color(0xff00C6FF),
    const Color(0xff7F00FF),
  ],
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AiChatPage(),
      ),
    );
  },
),
            ],
          ),
        ),
      ),
    );
  }
}