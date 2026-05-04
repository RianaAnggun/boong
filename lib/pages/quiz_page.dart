import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/user_data.dart';
import 'quiz_result_page.dart';
// import '../services/gemini_service.dart'; // DIHAPUS karena popup AI tidak dipakai

class QuizPage extends StatefulWidget {
  final int level;

  const QuizPage({
    super.key,
    required this.level,
  });

  @override
  State<QuizPage> createState() =>
      _QuizPageState();
}

class _QuizPageState extends State<QuizPage>
    with TickerProviderStateMixin {

  int currentQuestion = 1;
  int totalQuestion = 10;

  int score = 0;
  int streak = 0;
  int comboBonus = 0;

  int timeLeft = 30;
  int? selectedAnswer;

  Timer? timer;
  Random random = Random();

  List<Map<String, dynamic>>
      history = [];

  late int num1;
  late int num2;
  late String operatorSymbol;
  late int correctAnswer;

  List<int> options = [];

  late AnimationController pulse;

  @override
  void initState() {
    super.initState();

    pulse = AnimationController(
      vsync: this,
      duration:
          const Duration(
              milliseconds: 600),
    )..repeat(reverse: true);

    generateQuestion();
    startTimer();
  }

  void generateQuestion() {
    selectedAnswer = null;
    timeLeft = 30;

    int max = 10;

    if (widget.level == 2) {
      max = 30;
    } else if (widget.level == 3) {
      max = 100;
    }

    num1 = random.nextInt(max) + 1;
    num2 = random.nextInt(max) + 1;

    int type = random.nextInt(3);

    if (type == 0) {
      operatorSymbol = "+";
      correctAnswer =
          num1 + num2;
    } else if (type == 1) {
      operatorSymbol = "-";

      if (num1 < num2) {
        int t = num1;
        num1 = num2;
        num2 = t;
      }

      correctAnswer =
          num1 - num2;
    } else {
      operatorSymbol = "×";
      num1 =
          random.nextInt(10) +
              1;
      num2 =
          random.nextInt(10) +
              1;

      correctAnswer =
          num1 * num2;
    }

    options = [
      correctAnswer,
      correctAnswer + 1,
      correctAnswer - 1,
      correctAnswer + 2,
    ];

    options.shuffle();
  }

  void startTimer() {
    timer?.cancel();

    timer = Timer.periodic(
      const Duration(
          seconds: 1),
      (_) {
        if (timeLeft > 0) {
          setState(() {
            timeLeft--;
          });
        } else {
          streak = 0;
          nextQuestion();
        }
      },
    );
  }

/// HANYA PERBAIKI ERROR MERAH, TANPA POPUP AI

void chooseAnswer(int value) async {
  if (selectedAnswer != null) return;

  setState(() {
    selectedAnswer = value;
  });

  bool benar =
      value == correctAnswer;

  if (benar) {
    score += 10;

    if (operatorSymbol == "+") {
      UserData.addProgress += 10;
    }

    if (operatorSymbol == "-") {
      UserData.subProgress += 10;
    }

    if (operatorSymbol == "×") {
      UserData.mulProgress += 10;
    }
  }

  history.add({
    "a": num1,
    "b": num2,
    "op": operatorSymbol,
    "correct": correctAnswer,
    "user": value,
  });

  setState(() {});

  // Popup AI dihapus, langsung lanjut soal berikutnya
  Future.delayed(
    const Duration(
        milliseconds: 700),
    () {
      nextQuestion();
    },
  );
}

  Future<void> nextQuestion() async {
    timer?.cancel();

    if (currentQuestion <
        totalQuestion) {
      setState(() {
        currentQuestion++;
        generateQuestion();
      });

      startTimer();
    } else {

      UserData.totalPoint +=
          score;

      UserData.diamond +=
          score ~/ 20;

      UserData.quizHistory
          .add(score);

      if (UserData
              .quizHistory
              .length >
          7) {
        UserData.quizHistory
            .removeAt(0);
      }

      await UserData
          .saveData();

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              QuizResultPage(
            history: history,
          ),
        ),
      );
    }
  }

  Color getColor(int value) {
    if (selectedAnswer ==
        null) {
      return Colors.white;
    }

    if (value ==
        correctAnswer) {
      return Colors.green;
    }

    if (value ==
        selectedAnswer) {
      return Colors.red;
    }

    return Colors.white;
  }

  Widget answerButton(
      int value) {
    return GestureDetector(
      onTap: () =>
          chooseAnswer(value),
      child: AnimatedContainer(
        duration:
            const Duration(
                milliseconds:
                    250),
        width: double.infinity,
        margin:
            const EdgeInsets.only(
                bottom: 16),
        padding:
            const EdgeInsets.all(
                18),
        decoration:
            BoxDecoration(
          color: getColor(value),
          borderRadius:
              BorderRadius.circular(
                  22),
          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(
                      .08),
              blurRadius: 10,
            )
          ],
        ),
        child: Text(
          "$value",
          textAlign:
              TextAlign.center,
          style:
              TextStyle(
            fontSize: 24,
            fontWeight:
                FontWeight.bold,
            color:
                selectedAnswer ==
                        null
                    ? Colors.black
                    : Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(
      BuildContext context) {

    double progress =
        timeLeft / 30;

    return Scaffold(
      backgroundColor:
          AppTheme.bg,

      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.all(
                  18),
          child: Column(
            children: [

              Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                children: [

                  IconButton(
                    onPressed: () {
                      Navigator.pop(
                          context);
                    },
                    icon: const Icon(
                        Icons.arrow_back),
                  ),

                  Text(
                    "Soal $currentQuestion/$totalQuestion",
                    style:
                        const TextStyle(
                      fontSize: 20,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  CircleAvatar(
                    backgroundColor:
                        Colors.orange,
                    child: Text(
                      "$timeLeft",
                      style:
                          const TextStyle(
                        color: Colors
                            .white,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                  height: 12),

              LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                color:
                    AppTheme.blue,
              ),

              const SizedBox(
                  height: 18),

              Row(
                children: [

                  Expanded(
                    child: statBox(
                      "Score",
                      "$score",
                      Colors.blue,
                    ),
                  ),

                  const SizedBox(
                      width: 10),

                  Expanded(
                    child: statBox(
                      "Streak",
                      "$streak🔥",
                      Colors.orange,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                  height: 22),

              AnimatedBuilder(
                animation: pulse,
                builder:
                    (_, __) {
                  return Transform.scale(
                    scale: 1 +
                        pulse.value *
                            .02,
                    child:
                        Container(
                      width: double
                          .infinity,
                      padding:
                          const EdgeInsets.all(
                              24),
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
                      child: Text(
                        "$num1 $operatorSymbol $num2 = ?",
                        textAlign:
                            TextAlign
                                .center,
                        style:
                            const TextStyle(
                          fontSize:
                              32,
                          color: Colors
                              .white,
                          fontWeight:
                              FontWeight
                                  .bold,
                        ),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(
                  height: 20),

              Expanded(
                child: ListView(
                  children: options
                      .map(
                        (e) =>
                            answerButton(
                                e),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget statBox(
    String title,
    String value,
    Color color,
  ) {
    return Container(
      padding:
          const EdgeInsets.all(
              14),
      decoration:
          BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(
                20),
      ),
      child: Column(
        children: [

          Text(
            title,
            style:
                const TextStyle(
              color:
                  Colors.black54,
            ),
          ),

          const SizedBox(
              height: 6),

          Text(
            value,
            style:
                TextStyle(
              fontSize: 24,
              color: color,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}