import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'quiz_page.dart';

class LevelPage extends StatelessWidget {
  const LevelPage({super.key});

  Widget levelButton({
    required BuildContext context,
    required String title,
    required String desc,
    required Color color,
    required int level,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 3,
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => QuizPage(level: level),
            ),
          );
        },
        child: Row(
          children: [

            CircleAvatar(
              radius: 26,
              backgroundColor: color,
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    desc,
                    style: TextStyle(
                      color:
                          Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,

      appBar: AppBar(
        title: const Text(
          "Pilih Level",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const SizedBox(height: 10),

            levelButton(
              context: context,
              title: "MUDAH",
              desc: "Angka kecil untuk pemula",
              color: Colors.green,
              level: 1,
              icon: Icons.sentiment_satisfied,
            ),

            levelButton(
              context: context,
              title: "SEDANG",
              desc: "Lebih menantang dan cepat",
              color: Colors.orange,
              level: 2,
              icon: Icons.flash_on,
            ),

            levelButton(
              context: context,
              title: "SULIT",
              desc: "Untuk master matematika",
              color: Colors.red,
              level: 3,
              icon:
                  Icons.local_fire_department,
            ),
          ],
        ),
      ),
    );
  }
}