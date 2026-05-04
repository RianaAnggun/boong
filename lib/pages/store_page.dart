import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/user_data.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() =>
      _StorePageState();
}

class _StorePageState
    extends State<StorePage>
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
  }

  @override
  void dispose() {
    glow.dispose();
    super.dispose();
  }

  void showBuy(String text) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(text),
        behavior:
            SnackBarBehavior
                .floating,
      ),
    );
  }

  Widget itemCard({
    required String emoji,
    required String title,
    required String desc,
    required int price,
    required Color color,
    required VoidCallback onBuy,
  }) {
    return AnimatedBuilder(
      animation: glow,
      builder: (_, __) {
        return Container(
          margin:
              const EdgeInsets.only(
                  bottom: 18),
          padding:
              const EdgeInsets.all(
                  18),
          decoration:
              BoxDecoration(
            gradient:
                LinearGradient(
              colors: [
                color,
                color.withOpacity(
                    .75),
              ],
            ),
            borderRadius:
                BorderRadius.circular(
                    28),
            boxShadow: [
              BoxShadow(
                color: color
                    .withOpacity(
                        .20 +
                            glow.value *
                                .18),
                blurRadius: 20,
                offset:
                    const Offset(
                        0, 10),
              ),
            ],
          ),
          child: Row(
            children: [

              CircleAvatar(
                radius: 34,
                backgroundColor:
                    Colors.white24,
                child: Text(
                  emoji,
                  style:
                      const TextStyle(
                    fontSize: 28,
                  ),
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
                      desc,
                      style:
                          const TextStyle(
                        color: Colors
                            .white70,
                      ),
                    ),
                  ],
                ),
              ),

              ElevatedButton(
                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.white,
                  foregroundColor:
                      color,
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                            20),
                  ),
                ),
                onPressed: onBuy,
                child: Text(
                  "$price 💎",
                  style:
                      const TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget topInfoCard() {
    return Container(
      padding:
          const EdgeInsets.all(22),
      decoration:
          BoxDecoration(
        gradient:
            const LinearGradient(
          colors: [
            Color(0xffFFB347),
            Color(0xffFFCC33),
          ],
        ),
        borderRadius:
            BorderRadius.circular(
                28),
      ),
      child: Column(
        children: [

          const Text(
            "🛒 GAME STORE",
            style: TextStyle(
              fontSize: 30,
              fontWeight:
                  FontWeight.bold,
              color:
                  Colors.white,
            ),
          ),

          const SizedBox(
              height: 14),

          const Icon(
            Icons.diamond,
            size: 46,
            color: Colors.white,
          ),

          const SizedBox(
              height: 10),

          Text(
            "${UserData.diamond}",
            style:
                const TextStyle(
              fontSize: 36,
              fontWeight:
                  FontWeight.bold,
              color:
                  Colors.white,
            ),
          ),

          const Text(
            "YOUR DIAMOND",
            style: TextStyle(
              color:
                  Colors.white70,
              letterSpacing: 2,
            ),
          ),
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
                "Store"),
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
                    .all(18),
            child: Column(
              children: [

                topInfoCard(),

                const SizedBox(
                    height: 24),

                itemCard(
                  emoji: "⚡",
                  title:
                      "ENERGY +5",
                  desc:
                      "Tambah stamina bermain",
                  price: 10,
                  color:
                      Colors.orange,
                  onBuy: () async {
                    if (UserData
                            .diamond >=
                        10) {
                      UserData
                          .diamond -= 10;
                      UserData.energy +=
                          5;

                      await UserData
                          .saveData();

                      setState(() {});

                      showBuy(
                          "Energy berhasil dibeli!");
                    }
                  },
                ),

                itemCard(
                  emoji: "⭐",
                  title:
                      "POINT +100",
                  desc:
                      "Tambah total poin",
                  price: 20,
                  color:
                      Colors.green,
                  onBuy: () async {
                    if (UserData
                            .diamond >=
                        20) {
                      UserData
                          .diamond -= 20;
                      UserData
                          .totalPoint +=
                          100;

                      await UserData
                          .saveData();

                      setState(() {});

                      showBuy(
                          "Point berhasil dibeli!");
                    }
                  },
                ),

                itemCard(
                  emoji: "🎁",
                  title:
                      "MYSTERY BOX",
                  desc:
                      "Hadiah acak menarik",
                  price: 30,
                  color:
                      Colors.purple,
                  onBuy: () async {
                    if (UserData
                            .diamond >=
                        30) {
                      UserData
                          .diamond -= 30;

                      UserData
                          .totalPoint +=
                          150;

                      await UserData
                          .saveData();

                      setState(() {});

                      showBuy(
                          "Mystery Box dibuka!");
                    }
                  },
                ),

                const SizedBox(
                    height: 24),

                const Text(
                  "✨ New items coming soon...",
                  style: TextStyle(
                    fontSize: 16,
                    color:
                        Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}