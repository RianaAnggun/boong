import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/user_data.dart';

class SpinPage extends StatefulWidget {
  const SpinPage({super.key});

  @override
  State<SpinPage> createState() =>
      _SpinPageState();
}

class _SpinPageState
    extends State<SpinPage>
    with TickerProviderStateMixin {

  final List<Map<String, dynamic>>
      rewards = [
    {
      "text": "+50 POINT",
      "color": Colors.orange
    },
    {
      "text": "+100 POINT",
      "color": Colors.red
    },
    {
      "text": "+5 DIAMOND",
      "color": Colors.blue
    },
    {
      "text": "+10 DIAMOND",
      "color": Colors.indigo
    },
    {
      "text": "+1 ENERGY",
      "color": Colors.green
    },
    {
      "text": "JACKPOT +200",
      "color": Colors.purple
    },
  ];

  late AnimationController glow;
  bool spinning = false;
  double turns = 0;
  String result =
      "Tekan SPIN untuk hadiah!";

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

  Future<void> spinNow() async {
    if (spinning) return;

    spinning = true;

    int index =
        Random().nextInt(
            rewards.length);

    setState(() {
      turns +=
          8 +
          Random()
              .nextDouble() *
              5;
    });

    await Future.delayed(
      const Duration(
          seconds: 4),
    );

    result =
        rewards[index]["text"];

    if (result ==
        "+50 POINT") {
      UserData.totalPoint +=
          50;
    } else if (result ==
        "+100 POINT") {
      UserData.totalPoint +=
          100;
    } else if (result ==
        "+5 DIAMOND") {
      UserData.diamond += 5;
    } else if (result ==
        "+10 DIAMOND") {
      UserData.diamond += 10;
    } else if (result ==
        "+1 ENERGY") {
      UserData.energy += 1;
    } else {
      UserData.totalPoint +=
          200;
    }

    await UserData.saveData();

    spinning = false;

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
            const Text("🎉 SELAMAT"),
        content: Text(
          result,
          style:
              const TextStyle(
            fontSize: 28,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget rewardCard(
      String text,
      Color color) {
    return Container(
      margin:
          const EdgeInsets.only(
              bottom: 12),
      padding:
          const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(
                22),
        border: Border.all(
          color:
              color.withOpacity(
                  .35),
          width: 2,
        ),
      ),
      child: Row(
        children: [

          CircleAvatar(
            backgroundColor:
                color,
            child: const Icon(
              Icons.star,
              color:
                  Colors.white,
            ),
          ),

          const SizedBox(
              width: 14),

          Expanded(
            child: Text(
              text,
              style:
                  const TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.bold,
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
    return Scaffold(
      backgroundColor:
          AppTheme.bg,

      appBar: AppBar(
        title:
            const Text(
                "Lucky Spin"),
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
                            0xff7F00FF),
                        Color(
                            0xff00C6FF),
                      ],
                    ),
                    borderRadius:
                        BorderRadius.circular(
                            28),
                  ),
                  child: Column(
                    children: [

                      const Icon(
                        Icons
                            .casino,
                        color: Colors
                            .white,
                        size: 48,
                      ),

                      const SizedBox(
                          height:
                              10),

                      const Text(
                        "SPIN & WIN",
                        style:
                            TextStyle(
                          color: Colors
                              .white,
                          fontSize:
                              30,
                          fontWeight:
                              FontWeight
                                  .bold,
                        ),
                      ),

                      const SizedBox(
                          height:
                              8),

                      Text(
                        result,
                        style:
                            const TextStyle(
                          color: Colors
                              .white70,
                          fontSize:
                              16,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                    height: 30),

                Stack(
                  alignment:
                      Alignment
                          .center,
                  children: [

                    Positioned(
                      top: 0,
                      child: Icon(
                        Icons
                            .arrow_drop_down,
                        size: 50,
                        color: Colors
                            .red,
                      ),
                    ),

                    AnimatedBuilder(
                      animation:
                          glow,
                      builder:
                          (_, __) {
                        return Container(
                          width: 250,
                          height: 250,
                          decoration:
                              BoxDecoration(
                            shape: BoxShape
                                .circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors
                                    .purple
                                    .withOpacity(
                                        .2 +
                                            glow.value *
                                                .3),
                                blurRadius:
                                    30,
                              )
                            ],
                          ),
                          child:
                              AnimatedRotation(
                            turns:
                                turns,
                            duration:
                                const Duration(
                                    seconds:
                                        4),
                            curve: Curves
                                .easeOut,
                            child:
                                Container(
                              decoration:
                                  const BoxDecoration(
                                shape:
                                    BoxShape.circle,
                                gradient:
                                    SweepGradient(
                                  colors: [
                                    Colors.orange,
                                    Colors.red,
                                    Colors.blue,
                                    Colors.green,
                                    Colors.purple,
                                    Colors.orange,
                                  ],
                                ),
                              ),
                              child:
                                  const Center(
                                child:
                                    CircleAvatar(
                                  radius:
                                      45,
                                  backgroundColor:
                                      Colors.white,
                                  child:
                                      Icon(
                                    Icons.casino,
                                    size:
                                        55,
                                    color:
                                        Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(
                    height: 30),

                SizedBox(
                  width:
                      double.infinity,
                  child:
                      ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.orange,
                      padding:
                          const EdgeInsets
                              .all(
                                  18),
                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                                28),
                      ),
                      elevation: 10,
                    ),
                    onPressed:
                        spinNow,
                    child: Text(
                      spinning
                          ? "SPINNING..."
                          : "SPIN NOW",
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
                  ),
                ),

                const SizedBox(
                    height: 28),

                const Align(
                  alignment:
                      Alignment
                          .centerLeft,
                  child: Text(
                    "Reward Pool",
                    style:
                        TextStyle(
                      fontSize:
                          24,
                      fontWeight:
                          FontWeight
                              .bold,
                    ),
                  ),
                ),

                const SizedBox(
                    height: 14),

                ...rewards.map(
                  (e) =>
                      rewardCard(
                    e["text"],
                    e["color"],
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