import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'quiz_page.dart';

class QuizResultPage extends StatefulWidget {
  final List<Map<String, dynamic>> history;

  const QuizResultPage({
    super.key,
    required this.history,
  });

  @override
  State<QuizResultPage> createState() => _QuizResultPageState();
}

class _QuizResultPageState extends State<QuizResultPage>
    with TickerProviderStateMixin {
  late AnimationController scoreController;
  late Animation<double> scoreAnim;

  @override
  void initState() {
    super.initState();

    scoreController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    scoreAnim = Tween<double>(
      begin: 0,
      end: score.toDouble(),
    ).animate(
      CurvedAnimation(
        parent: scoreController,
        curve: Curves.easeOutExpo,
      ),
    );

    scoreController.forward();
  }

  @override
  void dispose() {
    scoreController.dispose();
    super.dispose();
  }

  int get totalCorrect => widget.history
      .where((e) => e["correct"] == e["user"])
      .length;

  int get totalWrong =>
      widget.history.length - totalCorrect;

  int get score =>
      ((totalCorrect / widget.history.length) * 100)
          .round();

  String getRank(int value) {
    if (value >= 95) return "MASTER";
    if (value >= 80) return "GOLD";
    if (value >= 60) return "SILVER";
    return "BRONZE";
  }

  Color getRankColor(int value) {
    if (value >= 95) return Colors.purple;
    if (value >= 80) return Colors.amber;
    if (value >= 60) return Colors.blue;
    return Colors.brown;
  }

  String makeSteps(
    int a,
    int b,
    String op,
    int answer,
  ) {
    if (op == "+") {
      return "$a + $b = $answer\nJumlahkan $a dan $b.";
    }

    if (op == "-") {
      return "$a - $b = $answer\nKurangi $a dengan $b.";
    }

    if (op == "×") {
      return "$a × $b = $answer\n$a × ${b ~/ 2} = ${a * (b ~/ 2)}\nLalu ×2 = $answer";
    }

    return "";
  }

  Widget resultCard(
    Map<String, dynamic> item,
    int index,
  ) {
    final bool correct =
        item["correct"] == item["user"];

    return Container(
      margin: const EdgeInsets.only(
          bottom: 18),
      padding:
          const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(
                26),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor:
                    correct
                        ? Colors.green
                        : Colors.red,
                child: Icon(
                  correct
                      ? Icons.check
                      : Icons.close,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              const SizedBox(
                  width: 10),
              Text(
                "Soal ${index + 1}",
                style:
                    const TextStyle(
                  fontSize: 22,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(
              height: 14),

          Text(
            "${item["a"]} ${item["op"]} ${item["b"]} = ${item["correct"]}",
            style:
                const TextStyle(
              fontSize: 28,
              color: Colors.blue,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
              height: 8),

          Text(
            "Jawaban Kamu: ${item["user"]}",
            style: TextStyle(
              fontSize: 17,
              fontWeight:
                  FontWeight.bold,
              color: correct
                  ? Colors.green
                  : Colors.red,
            ),
          ),

          const SizedBox(
              height: 14),

          Container(
            width:
                double.infinity,
            padding:
                const EdgeInsets
                    .all(14),
            decoration:
                BoxDecoration(
              color:
                  const Color(
                      0xffF4F7FF),
              borderRadius:
                  BorderRadius.circular(
                      18),
            ),
            child: Text(
              makeSteps(
                item["a"],
                item["b"],
                item["op"],
                item["correct"],
              ),
              style:
                  const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget scoreBox() {
    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.all(26),
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(
                34),
        gradient:
            const LinearGradient(
          begin:
              Alignment.topLeft,
          end: Alignment
              .bottomRight,
          colors: [
            Color(0xffF8F9FF),
            Color(0xffEAF2FF),
          ],
        ),
        border: Border.all(
          color:
              Colors.white70,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black12,
            blurRadius: 18,
            offset:
                const Offset(
                    0, 10),
          ),
          BoxShadow(
            color: Colors.blue
                .withOpacity(.15),
            blurRadius: 14,
          ),
        ],
      ),
      child: Column(
        children: [
          AnimatedBuilder(
            animation:
                scoreAnim,
            builder:
                (_, __) {
              return ShaderMask(
                shaderCallback:
                    (rect) {
                  return const LinearGradient(
                    colors: [
                      Color(
                          0xff7F00FF),
                      Color(
                          0xff00C6FF),
                    ],
                  ).createShader(
                      rect);
                },
                child: Text(
                  "${scoreAnim.value.toInt()}",
                  style:
                      const TextStyle(
                    fontSize: 78,
                    fontWeight:
                        FontWeight.bold,
                    color:
                        Colors.white,
                  ),
                ),
              );
            },
          ),

          const SizedBox(
              height: 4),

          const Text(
            "Score",
            style: TextStyle(
              fontSize: 20,
              color:
                  Colors.black54,
              fontWeight:
                  FontWeight.w600,
            ),
          ),

          const SizedBox(
              height: 24),

          Row(
            children: [
              Expanded(
                child: statItem(
                  Icons.check,
                  const [
                    Color(
                        0xff67E667),
                    Color(
                        0xff1DB954),
                  ],
                  "$totalCorrect",
                  "Benar",
                ),
              ),

              Container(
                width: 1,
                height: 100,
                color:
                    Colors.black12,
              ),

              Expanded(
                child: statItem(
                  Icons.close,
                  const [
                    Color(
                        0xffFF7C7C),
                    Color(
                        0xffFF3D57),
                  ],
                  "$totalWrong",
                  "Salah",
                ),
              ),
            ],
          ),

          const SizedBox(
              height: 26),

          Container(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 10,
            ),
            decoration:
                BoxDecoration(
              borderRadius:
                  BorderRadius.circular(
                      28),
              gradient:
                  LinearGradient(
                colors: [
                  getRankColor(
                      score),
                  getRankColor(
                          score)
                      .withOpacity(
                          .75),
                ],
              ),
            ),
            child: Row(
              mainAxisSize:
                  MainAxisSize.min,
              children: [
                const Icon(
                  Icons
                      .emoji_events,
                  color:
                      Colors.white,
                ),
                const SizedBox(
                    width: 8),
                Text(
                  getRank(score),
                  style:
                      const TextStyle(
                    color:
                        Colors.white,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget statItem(
    IconData icon,
    List<Color> colors,
    String value,
    String label,
  ) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration:
              BoxDecoration(
            gradient:
                LinearGradient(
              colors: colors,
            ),
            borderRadius:
                BorderRadius.circular(
                    22),
          ),
          child: Icon(
            icon,
            color:
                Colors.white,
            size: 42,
          ),
        ),
        const SizedBox(
            height: 12),
        Text(
          value,
          style:
              const TextStyle(
            fontSize: 36,
            fontWeight:
                FontWeight.bold,
            color:
                Color(0xff442AE6),
          ),
        ),
        Text(
          label,
          style:
              const TextStyle(
            color:
                Colors.black54,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(
      BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppTheme.bg,
      body: SafeArea(
        child:
            SingleChildScrollView(
          child: Column(
            children: [
              // HEADER
              Container(
                width:
                    double.infinity,
                padding:
                    const EdgeInsets
                        .fromLTRB(
                            20,
                            20,
                            20,
                            28),
                decoration:
                    const BoxDecoration(
                  gradient:
                      LinearGradient(
                    begin:
                        Alignment
                            .topLeft,
                    end: Alignment
                        .bottomRight,
                    colors: [
                      Color(
                          0xff7F00FF),
                      Color(
                          0xff00C6FF),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed:
                              () {
                            Navigator.pop(
                                context);
                          },
                          icon:
                              const Icon(
                            Icons
                                .arrow_back,
                            color: Colors
                                .white,
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            "🎉 Quiz Selesai",
                            textAlign:
                                TextAlign.center,
                            style:
                                TextStyle(
                              color:
                                  Colors.white,
                              fontSize:
                                  30,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                            width:
                                48),
                      ],
                    ),

                    const SizedBox(
                        height: 20),

                    scoreBox(),
                  ],
                ),
              ),

              const SizedBox(
                  height: 20),

              const Padding(
                padding:
                    EdgeInsets.symmetric(
                        horizontal:
                            18),
                child: Align(
                  alignment:
                      Alignment
                          .centerLeft,
                  child: Text(
                    "📘 Pembahasan Soal",
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
                  height: 18),

              Padding(
                padding:
                    const EdgeInsets
                        .symmetric(
                            horizontal:
                                18),
                child: Column(
                  children: widget
                      .history
                      .asMap()
                      .entries
                      .map(
                        (e) =>
                            resultCard(
                          e.value,
                          e.key,
                        ),
                      )
                      .toList(),
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets
                        .all(18),
                child: Row(
                  children: [
                    Expanded(
                      child:
                          ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.grey,
                          padding:
                              const EdgeInsets.all(
                                  16),
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                                    18),
                          ),
                        ),
                        onPressed:
                            () {
                          Navigator.pop(
                              context);
                        },
                        child:
                            const Text(
                          "Kembali",
                          style:
                              TextStyle(
                            color:
                                Colors.white,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                        width: 12),

                    Expanded(
                      child:
                          ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              AppTheme.blue,
                          padding:
                              const EdgeInsets.all(
                                  16),
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                                    18),
                          ),
                        ),
                        onPressed:
                            () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) =>
                                      const QuizPage(
                                level: 1,
                              ),
                            ),
                          );
                        },
                        child:
                            const Text(
                          "Main Lagi",
                          style:
                              TextStyle(
                            color:
                                Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}