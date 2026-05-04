import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/user_data.dart';
import 'home_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() =>
      _LoginPageState();
}

class _LoginPageState
    extends State<LoginPage>
    with TickerProviderStateMixin {

  late AnimationController pulse;
  late AnimationController floatAnim;

  final TextEditingController username =
      TextEditingController();

  final TextEditingController password =
      TextEditingController();

  bool hidePass = true;
  bool loading = false;

  @override
  void initState() {
    super.initState();

    pulse = AnimationController(
      vsync: this,
      duration:
          const Duration(
              milliseconds: 1800),
    )..repeat(reverse: true);

    floatAnim = AnimationController(
      vsync: this,
      duration:
          const Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    pulse.dispose();
    floatAnim.dispose();
    username.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> loginNow() async {
    if (username.text.trim().isEmpty ||
        password.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Isi username & password",
          ),
        ),
      );
      return;
    }

    setState(() {
      loading = true;
    });

    await Future.delayed(
      const Duration(seconds: 1),
    );

    UserData.username =
        username.text.trim();

    UserData.isLogin = true;

    await UserData.saveData();

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const HomePage(),
      ),
    );
  }

  Widget inputBox({
    required String hint,
    required IconData icon,
    bool obscure = false,
    TextEditingController? controller,
  }) {
    return Container(
      margin:
          const EdgeInsets.only(
              bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(
                24),
        boxShadow: [
          BoxShadow(
            color: Colors.blue
                .withOpacity(.08),
            blurRadius: 18,
            offset:
                const Offset(0, 8),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText:
            obscure ? hidePass : false,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.all(
                  20),
          hintText: hint,
          prefixIcon: Icon(
            icon,
            color: AppTheme.blue,
          ),
          suffixIcon: obscure
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      hidePass =
                          !hidePass;
                    });
                  },
                  icon: Icon(
                    hidePass
                        ? Icons
                            .visibility_off
                        : Icons
                            .visibility,
                  ),
                )
              : null,
        ),
      ),
    );
  }

  Widget particle(
    String text,
    double top,
    double left,
    double size,
    Color color,
  ) {
    return Positioned(
      top: top,
      left: left,
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
  }

  @override
  Widget build(
      BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation:
            Listenable.merge([
          pulse,
          floatAnim,
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
                  120 +
                      (pulse.value * 10),
                  40,
                  80,
                  Colors.blue,
                ),

                particle(
                  "%",
                  180,
                  320 +
                      (pulse.value * 10),
                  90,
                  Colors.indigo,
                ),

                particle(
                  "7",
                  700 -
                      (pulse.value * 10),
                  70,
                  100,
                  Colors.green,
                ),

                particle(
                  "×",
                  760,
                  310 -
                      (pulse.value * 8),
                  90,
                  Colors.purple,
                ),

                SafeArea(
                  child: Center(
                    child:
                        SingleChildScrollView(
                      padding:
                          const EdgeInsets
                              .all(24),
                      child: Column(
                        children: [

                          Transform.scale(
                            scale:
                                .95 +
                                    pulse.value *
                                        .05,
                            child:
                                Container(
                              width: 130,
                              height: 130,
                              decoration:
                                  BoxDecoration(
                                color: Colors
                                    .white,
                                borderRadius:
                                    BorderRadius.circular(
                                        34),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors
                                        .blue
                                        .withOpacity(
                                            .18),
                                    blurRadius:
                                        24,
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
                                        60,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(
                              height: 24),

                          Text(
                            "MathRush",
                            style:
                                TextStyle(
                              fontSize:
                                  36,
                              fontWeight:
                                  FontWeight
                                      .bold,
                              color:
                                  AppTheme
                                      .blue,
                            ),
                          ),

                          const SizedBox(
                              height: 8),

                          const Text(
                            "LOGIN TO START\nYOUR ADVENTURE",
                            textAlign:
                                TextAlign
                                    .center,
                            style:
                                TextStyle(
                              fontSize:
                                  18,
                              letterSpacing:
                                  3,
                              height:
                                  1.5,
                              color: Color(
                                  0xff6A7BAA),
                            ),
                          ),

                          const SizedBox(
                              height: 34),

                          inputBox(
                            hint:
                                "Username",
                            icon: Icons
                                .person,
                            controller:
                                username,
                          ),

                          inputBox(
                            hint:
                                "Password",
                            icon: Icons
                                .lock,
                            obscure:
                                true,
                            controller:
                                password,
                          ),

                          const SizedBox(
                              height: 8),

                          SizedBox(
                            width:
                                double.infinity,
                            child:
                                ElevatedButton(
                              onPressed:
                                  loading
                                      ? null
                                      : loginNow,
                              style:
                                  ElevatedButton.styleFrom(
                                backgroundColor:
                                    AppTheme
                                        .blue,
                                padding:
                                    const EdgeInsets.symmetric(
                                  vertical:
                                      18,
                                ),
                                elevation:
                                    10,
                                shadowColor:
                                    Colors
                                        .blue
                                        .withOpacity(
                                            .35),
                                shape:
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(
                                          22),
                                ),
                              ),
                              child:
                                  loading
                                      ? const SizedBox(
                                          width:
                                              24,
                                          height:
                                              24,
                                          child:
                                              CircularProgressIndicator(
                                            color:
                                                Colors.white,
                                            strokeWidth:
                                                3,
                                          ),
                                        )
                                      : const Text(
                                          "LOGIN",
                                          style:
                                              TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                            ),
                          ),

                          const SizedBox(
                              height: 18),

                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) =>
                                          const RegisterPage(),
                                ),
                              );
                            },
                            child:
                                RichText(
                              text:
                                  TextSpan(
                                style:
                                    const TextStyle(
                                  fontSize:
                                      16,
                                ),
                                children: [
                                  const TextSpan(
                                    text:
                                        "Belum punya akun? ",
                                    style:
                                        TextStyle(
                                      color: Colors.black54,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        "Register",
                                    style:
                                        TextStyle(
                                      color:
                                          AppTheme.blue,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
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
}