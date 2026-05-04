import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'quiz_page.dart';
import 'home_page.dart';

class ResultPage extends StatelessWidget {
  final int score;
  final int level;

const ResultPage({
  super.key,
  required this.score,
  required this.level,
});

  String getMessage() {
    if (score >= 80) {
      return "Luar Biasa!";
    } else if (score >= 50) {
      return "Bagus!";
    } else {
      return "Coba Lagi!";
    }
  }

  String getEmoji() {
    if (score >= 80) {
      return "🏆";
    } else if (score >= 50) {
      return "🎉";
    } else {
      return "💪";
    }
  }

  String getBadgeTitle() {
  if (score >= 80) {
    return "Master Matematika";
  } else if (score >= 50) {
    return "Pemain Hebat";
  } else {
    return "Pejuang Angka";
  }
}

Color getBadgeColor() {
  if (score >= 80) {
    return Colors.amber;
  } else if (score >= 50) {
    return Colors.blue;
  } else {
    return Colors.green;
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,

      body: SafeArea(
  child: SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [

              Text(
                getEmoji(),
                style: const TextStyle(
                  fontSize: 80,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                getMessage(),
                style: TextStyle(
                  fontSize: 34,
                  fontWeight:
                      FontWeight.bold,
                  color: AppTheme.blue,
                ),
              ),

              const SizedBox(height: 30),

Container(
  padding: const EdgeInsets.symmetric(
    horizontal: 24,
    vertical: 12,
  ),
  decoration: BoxDecoration(
    color: getBadgeColor(),
    borderRadius:
        BorderRadius.circular(30),
  ),
  child: Text(
    getBadgeTitle(),
    style: const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
),

const SizedBox(height: 28),

              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(
                          30),
                ),
                child: Column(
                  children: [

                    const Text(
                      "SKOR AKHIR",
                      style: TextStyle(
                        letterSpacing: 2,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 18),

                    Text(
                      "$score",
                      style: TextStyle(
                        fontSize: 52,
                        fontWeight:
                            FontWeight.bold,
                        color:
                            AppTheme.blue,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        AppTheme.blue,
                    padding:
                        const EdgeInsets
                            .all(18),
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius
                              .circular(
                                  40),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                       builder: (_) => QuizPage(level: level),
                      ),
                    );
                  },
                  child: const Text(
                    "Main Lagi",
                    style: TextStyle(
                      color:
                          Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style:
                      OutlinedButton.styleFrom(
                    padding:
                        const EdgeInsets
                            .all(18),
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius
                              .circular(
                                  40),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const HomePage(),
                      ),
                      (route) => false,
                    );
                  },
                  child: const Text(
                    "Kembali Home",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
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