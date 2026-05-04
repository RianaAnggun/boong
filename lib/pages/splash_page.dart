import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../data/user_data.dart';
import 'home_page.dart';
import 'login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() =>
      _SplashPageState();
}

class _SplashPageState
    extends State<SplashPage>
    with TickerProviderStateMixin {

  late AnimationController logo;
  late AnimationController pulse;
  late AnimationController loading;
  late AnimationController floatAnim;

  bool showNextButton = false;

  final List<String> facts = [
    "Tahukah kamu? Matematika adalah bahasa alam semesta.",
    "1 menit latihan tiap hari lebih kuat dari 1 jam seminggu sekali.",
    "Orang hebat juga pernah bingung menghitung.",
    "Level berikutnya menunggumu!",
  ];

  int factIndex = 0;
  Timer? factTimer;

  @override
  void initState() {
    super.initState();

    startAnimation();
    startLoading();
  }

  void startAnimation() {
    logo = AnimationController(
      vsync: this,
      duration:
          const Duration(
              milliseconds: 1400),
    )..forward();

    pulse = AnimationController(
      vsync: this,
      duration:
          const Duration(
              milliseconds: 1800),
    )..repeat(reverse: true);

    loading = AnimationController(
      vsync: this,
      duration:
          const Duration(seconds: 4),
    )..forward();

    floatAnim = AnimationController(
      vsync: this,
      duration:
          const Duration(seconds: 5),
    )..repeat();

    factTimer = Timer.periodic(
      const Duration(
          milliseconds: 1400),
      (_) {
        if (!mounted) return;

        setState(() {
          factIndex =
              (factIndex + 1) %
                  facts.length;
        });
      },
    );
  }

  Future<void> startLoading() async {
    await UserData.loadData();

    await Future.delayed(
      const Duration(seconds: 4),
    );

    if (!mounted) return;

    if (UserData.isLogin) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              const HomePage(),
        ),
      );
    } else {
      setState(() {
        showNextButton = true;
      });
    }
  }

  void goNext() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const LoginPage(),
      ),
    );
  }

  @override
  void dispose() {
    logo.dispose();
    pulse.dispose();
    loading.dispose();
    floatAnim.dispose();
    factTimer?.cancel();
    super.dispose();
  }

  Widget particle(
    String text,
    double top,
    double left,
    double size,
    Color color,
  ) {
    return AnimatedBuilder(
      animation: floatAnim,
      builder: (_, __) {
        return Positioned(
          top:
              top +
                  sin(
                        floatAnim
                                .value *
                            6.28,
                      ) *
                      12,
          left:
              left +
                  cos(
                        floatAnim
                                .value *
                            6.28,
                      ) *
                      10,
          child: Opacity(
            opacity: .10,
            child: Text(
              text,
              style: TextStyle(
                fontSize: size,
                fontWeight:
                    FontWeight.bold,
                color: color,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(
      BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation:
            Listenable.merge([
          pulse,
          logo,
          loading,
        ]),
        builder: (_, __) {
          return Container(
            decoration:
                const BoxDecoration(
              gradient:
                  LinearGradient(
                begin:
                    Alignment.topLeft,
                end: Alignment
                    .bottomRight,
                colors: [
                  Color(0xffD7ECFF),
                  Color(0xffF6F3FF),
                ],
              ),
            ),
            child: Stack(
              children: [

                particle(
                  "+",
                  120,
                  80,
                  90,
                  Colors.blue,
                ),

                particle(
                  "%",
                  170,
                  500,
                  100,
                  Colors.blue,
                ),

                particle(
                  "7",
                  430,
                  120,
                  110,
                  Colors.indigo,
                ),

                particle(
                  "×",
                  760,
                  50,
                  100,
                  Colors.green,
                ),

                particle(
                  "11",
                  780,
                  440,
                  100,
                  Colors.purple,
                ),

                SafeArea(
                  child: Padding(
                            padding: const EdgeInsets.symmetric(
  horizontal: 24,
  vertical: 18,
),
                    child: Column(
                      children: [

                        const Spacer(),

                        Transform.scale(
                          scale:
                              .7 +
                                  logo.value *
                                      .3 +
                                  pulse.value *
                                      .03,
                          child:
                              Container(
                            width: 140,
                            height: 140,
                            decoration:
                                BoxDecoration(
                              color: Colors
                                  .white,
                              borderRadius:
                                  BorderRadius.circular(
                                      42),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors
                                      .blue
                                      .withOpacity(
                                          .18),
                                  blurRadius:
                                      30,
                                ),
                              ],
                            ),
                            child:
                                const Center(
                              child: Text(
                                "🚀",
                                style:
                                    TextStyle(
                                  fontSize:
                                      70,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                            height: 26),

                        const Text(
                          "MathRush",
                          style:
                              TextStyle(
                            fontSize: 34,
                            fontWeight:
                                FontWeight.bold,
                            color: Color(
                                0xff0D47A1),
                          ),
                        ),

                        const SizedBox(
                            height: 12),

                        const Text(
                          "PETUALANGAN ANGKA\nMENANTIMU",
                          textAlign:
                              TextAlign.center,
                          style:
                              TextStyle(
                            fontSize: 21,
                            letterSpacing:
                                6,
                            height: 1.5,
                            color: Color(
                                0xff6A7BAA),
                          ),
                        ),

                        const SizedBox(
                            height: 36),

                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(
                                  30),
                          child:
                              Container(
                            height: 18,
                            color: const Color(
                                0xffC9D8FF),
                            child: Align(
                              alignment:
                                  Alignment
                                      .centerLeft,
                              child:
                                  FractionallySizedBox(
                                widthFactor:
                                    loading
                                        .value,
                                child:
                                    Container(
                                  decoration:
                                      const BoxDecoration(
                                    gradient:
                                        LinearGradient(
                                      colors: [
                                        Color(
                                            0xff1565C0),
                                        Color(
                                            0xff64B5F6),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                            height: 30),

                        if (!showNextButton)
                          const Text(
                            "Loading...",
                            style:
                                TextStyle(
                              fontSize:
                                  18,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                        if (showNextButton)
                          SizedBox(
                            width:
                                double.infinity,
                            child:
                                ElevatedButton(
                              onPressed:
                                  goNext,
                              style:
                                  ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color(
                                        0xff1565C0),
                                padding:
                                    const EdgeInsets.symmetric(
                                  vertical:
                                      18,
                                ),
                                shape:
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(
                                          20),
                                ),
                              ),
                              child:
                                  const Text(
                                "NEXT ▶",
                                style:
                                    TextStyle(
                                  fontSize:
                                      20,
                                  fontWeight:
                                      FontWeight.bold,
                                  color: Colors
                                      .white,
                                ),
                              ),
                            ),
                          ),

                        const SizedBox(
                            height: 30),

                        Text(
                          facts[
                              factIndex],
                          textAlign:
                              TextAlign.center,
                          style:
                              const TextStyle(
                            fontSize: 16,
                            fontStyle:
                                FontStyle.italic,
                            color: Color(
                                0xff52628F),
                          ),
                        ),

                        const Spacer(),
                      ],
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
}