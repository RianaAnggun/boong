import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/user_data.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() =>
      _LeaderboardPageState();
}

class _LeaderboardPageState
    extends State<LeaderboardPage>
    with TickerProviderStateMixin {

  late AnimationController glow;
  late AnimationController podiumAnim;

  @override
  void initState() {
    super.initState();

    glow = AnimationController(
      vsync: this,
      duration:
          const Duration(seconds: 2),
    )..repeat(reverse: true);

    podiumAnim = AnimationController(
      vsync: this,
      duration:
          const Duration(
              milliseconds: 1400),
    )..forward();
  }

  @override
  void dispose() {
    glow.dispose();
    podiumAnim.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>>
      getPlayers() {
    return [
      {
        "name": "AnaKece",
        "score": 5200,
        "icon": "👑",
      },
      {
        "name": "JijahCokrong",
        "score": 4100,
        "icon": "🔥",
      },
      {
        "name": "LarasMerah",
        "score": 3600,
        "icon": "😎",
      },
      {
        "name": UserData.username,
        "score":
            UserData.totalPoint,
        "icon":
            UserData.avatar,
      },
      {
        "name": "JenabFore",
        "score": 3300,
        "icon": "⭐",
      },
      {
        "name": "MimahMelet",
        "score": 2900,
        "icon": "🦖",
      },
      {
        "name": "DedesBojong",
        "score": 2600,
        "icon": "🌙",
      },
      {
        "name": "NasiwaDuta",
        "score": 2200,
        "icon": "⚔️",
      },
    ];
  }

  LinearGradient rankGradient(
      int rank) {
    if (rank == 0) {
      return const LinearGradient(
        colors: [
          Color(0xffFFD54F),
          Color(0xffFFB300),
        ],
      );
    }

    if (rank == 1) {
      return const LinearGradient(
        colors: [
          Color(0xffECEFF1),
          Color(0xffB0BEC5),
        ],
      );
    }

    return const LinearGradient(
      colors: [
        Color(0xffFFCC80),
        Color(0xffFB8C00),
      ],
    );
  }

  Widget podiumBox(
    int rank,
    Map<String, dynamic> p,
    double height,
  ) {
    return Expanded(
      child: AnimatedBuilder(
        animation:
            Listenable.merge([
          glow,
          podiumAnim,
        ]),
        builder: (_, __) {

          double startY = 160;

          double move =
              startY -
              (startY *
                  Curves.easeOutBack
                      .transform(
                          podiumAnim
                              .value));

          return Transform.translate(
            offset:
                Offset(0, move),
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment
                      .end,
              children: [

                CircleAvatar(
                  radius:
                      rank == 0
                          ? 30
                          : 24,
                  backgroundColor:
                      Colors.white,
                  child: Text(
                    p["icon"],
                    style:
                        const TextStyle(
                      fontSize:
                          24,
                    ),
                  ),
                ),

                const SizedBox(
                    height: 8),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(
                          horizontal:
                              4),
                  child: Text(
                    p["name"],
                    maxLines: 1,
                    overflow:
                        TextOverflow
                            .ellipsis,
                    textAlign:
                        TextAlign.center,
                    style:
                        const TextStyle(
                      color:
                          Colors.white,
                      fontSize: 13,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),

                Text(
                  "${p["score"]}",
                  style:
                      const TextStyle(
                    color:
                        Colors.white70,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(
                    height: 8),

                Container(
                  height: height,
                  margin:
                      const EdgeInsets.symmetric(
                          horizontal:
                              4),
                  decoration:
                      BoxDecoration(
                    gradient:
                        rankGradient(
                            rank),
                    borderRadius:
                        const BorderRadius.vertical(
                      top:
                          Radius.circular(
                              22),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors
                            .black12,
                        blurRadius:
                            14 +
                                glow.value *
                                    8,
                      )
                    ],
                  ),
                  child: Center(
                    child: Text(
                      rank == 0
                          ? "👑"
                          : rank == 1
                              ? "🥈"
                              : "🥉",
                      style:
                          const TextStyle(
                        fontSize:
                            28,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget topTile(
    int rank,
    Map<String, dynamic> p,
  ) {
    return Container(
      margin:
          const EdgeInsets.only(
              bottom: 16),
      padding:
          const EdgeInsets.all(
              18),
      decoration:
          BoxDecoration(
        gradient:
            rankGradient(rank),
        borderRadius:
            BorderRadius.circular(
                28),
        boxShadow: const [
          BoxShadow(
            color:
                Colors.black12,
            blurRadius: 10,
          )
        ],
      ),
      child: Row(
        children: [

          CircleAvatar(
            radius: 28,
            backgroundColor:
                Colors.white,
            child: Text(
              p["icon"],
              style:
                  const TextStyle(
                fontSize: 24,
              ),
            ),
          ),

          const SizedBox(
              width: 14),

          Expanded(
            child: Text(
              p["name"],
              maxLines: 1,
              overflow:
                  TextOverflow
                      .ellipsis,
              style:
                  const TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),

          Text(
            "${p["score"]}",
            style:
                const TextStyle(
              fontSize: 24,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget normalTile(
    int i,
    Map<String, dynamic> p,
  ) {
    return Container(
      margin:
          const EdgeInsets.only(
              bottom: 14),
      padding:
          const EdgeInsets.all(
              16),
      decoration:
          BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(
                24),
        boxShadow: const [
          BoxShadow(
            color:
                Colors.black12,
            blurRadius: 8,
          )
        ],
      ),
      child: Row(
        children: [

          Text(
            "#${i + 1}",
            style:
                TextStyle(
              fontSize: 18,
              fontWeight:
                  FontWeight.bold,
              color:
                  AppTheme.blue,
            ),
          ),

          const SizedBox(
              width: 14),

          CircleAvatar(
            radius: 22,
            backgroundColor:
                AppTheme.blue,
            child: Text(
              p["icon"],
              style:
                  const TextStyle(
                fontSize: 18,
              ),
            ),
          ),

          const SizedBox(
              width: 14),

          Expanded(
            child: Text(
              p["name"],
              maxLines: 1,
              overflow:
                  TextOverflow
                      .ellipsis,
              style:
                  const TextStyle(
                fontSize: 20,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),

          Text(
            "${p["score"]}",
            style:
                TextStyle(
              fontSize: 22,
              fontWeight:
                  FontWeight.bold,
              color:
                  AppTheme.blue,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(
      BuildContext context) {

    final data =
        getPlayers();

    data.sort(
      (a, b) => b["score"]
          .compareTo(
              a["score"]),
    );

    final double width =
        MediaQuery.of(context)
            .size
            .width;

    final double podiumArea =
        width < 420
            ? 310
            : 340;

    return Scaffold(
      backgroundColor:
          AppTheme.bg,

      appBar: AppBar(
        title:
            const Text(
                "Leaderboard"),
        centerTitle: true,
        backgroundColor:
            Colors.transparent,
      ),

      body:
          SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.all(
                  16),
          child: Column(
            children: [

              Container(
                padding:
                    const EdgeInsets.all(
                        18),
                decoration:
                    BoxDecoration(
                  gradient:
                      const LinearGradient(
                    colors: [
                      Color(0xff7F00FF),
                      Color(0xff00C6FF),
                    ],
                  ),
                  borderRadius:
                      BorderRadius.circular(
                          28),
                ),
                child: Column(
                  children: [

                    const Text(
                      "🏆 TOP PLAYERS 🏆",
                      style:
                          TextStyle(
                        fontSize: 26,
                        color:
                            Colors.white,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                        height: 20),

                    SizedBox(
                      height:
                          podiumArea,
                      child: Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.end,
                        children: [

                          podiumBox(
                            1,
                            data[1],
                            110,
                          ),

                          podiumBox(
                            0,
                            data[0],
                            145,
                          ),

                          podiumBox(
                            2,
                            data[2],
                            95,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                  height: 18),

              topTile(0, data[0]),
              topTile(1, data[1]),
              topTile(2, data[2]),

              const SizedBox(
                  height: 8),

              ListView.builder(
                itemCount:
                    data.length - 3,
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(),
                itemBuilder:
                    (_, i) {
                  return normalTile(
                    i + 3,
                    data[i + 3],
                  );
                },
              ),

              const SizedBox(
                  height: 30),
            ],
          ),
        ),
      ),
    );
  }
}