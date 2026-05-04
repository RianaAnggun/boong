import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/user_data.dart';
import 'leaderboard_page.dart';
import 'progress_page.dart';
import 'splash_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() =>
      _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = "Math Warrior";

  final List<String> avatars = [
    "🐼",
    "🐸",
    "🐱",
    "🐵",
    "🦊",
    "🐯",
    "🐨",
    "🐧",
    "🦁",
    "🤖",
    "👑",
    "🐲",
  ];

  int selectedAvatar = 0;

  @override
  void initState() {
    super.initState();
    userName = UserData.username;
    int idx = avatars.indexOf(UserData.avatar);
    selectedAvatar = idx >= 0 ? idx : 0;
  }

  void editProfile() {
    TextEditingController name =
        TextEditingController(
      text: userName,
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape:
          const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            left: 18,
            right: 18,
            top: 18,
            bottom:
                MediaQuery.of(context)
                        .viewInsets
                        .bottom +
                    20,
          ),
          child: Column(
            mainAxisSize:
                MainAxisSize.min,
            children: [
              const Text(
                "Edit Profile",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
              const SizedBox(
                  height: 18),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: avatars
                    .asMap()
                    .entries
                    .map((e) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedAvatar =
                            e.key;
                      });
                    },
                    child: CircleAvatar(
                      radius: 28,
                      backgroundColor:
                          selectedAvatar ==
                                  e.key
                              ? AppTheme.blue
                              : Colors.grey
                                  .shade200,
                      child: Text(
                        e.value,
                        style:
                            const TextStyle(
                          fontSize: 26,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(
                  height: 18),
              TextField(
                controller: name,
                decoration:
                    InputDecoration(
                  hintText:
                      "Nama pengguna",
                  filled: true,
                  fillColor:
                      Colors.grey
                          .shade100,
                  border:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(
                            18),
                    borderSide:
                        BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(
                  height: 18),
              SizedBox(
                width:
                    double.infinity,
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
                  onPressed: () async {
                    setState(() {
                      userName = name
                              .text
                              .trim()
                              .isEmpty
                          ? "Math Warrior"
                          : name.text
                              .trim();
                    });

                    UserData.username =
                        userName;
                    UserData.avatar =
                        avatars[
                            selectedAvatar];

                    await UserData
                        .saveData();

                    if (!mounted) {
                      return;
                    }

                    Navigator.pop(
                        context);
                  },
                  child:
                      const Text(
                    "Save",
                    style:
                        TextStyle(
                      color: Colors
                          .white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void openSettingSidebar() {
    showModalBottomSheet(
      context: context,
      backgroundColor:
          Colors.white,
      shape:
          const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(
          top:
              Radius.circular(
                  30),
        ),
      ),
      builder: (_) {
        return Padding(
          padding:
              const EdgeInsets.all(
                  20),
          child: Column(
            mainAxisSize:
                MainAxisSize.min,
            children: [
              const Text(
                "Settings",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
              const SizedBox(
                  height: 18),
              ListTile(
                leading:
                    const Icon(
                  Icons.person,
                  color:
                      Colors.blue,
                ),
                title: const Text(
                    "Edit Profile"),
                onTap: () {
                  Navigator.pop(
                      context);
                  editProfile();
                },
              ),
              ListTile(
                leading:
                    const Icon(
                  Icons.logout,
                  color:
                      Colors.red,
                ),
                title: const Text(
                    "Logout"),
                onTap: () {
                  Navigator.pop(
                      context);
                  showLogoutDialog();
                },
              ),
            ],
          ),
        );
      },
    );
  }

void showLogoutDialog() {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Logout",
    barrierColor: Colors.black.withOpacity(.45),
    transitionDuration: const Duration(milliseconds: 280),
    pageBuilder: (_, __, ___) {
      return const SizedBox();
    },
    transitionBuilder: (_, animation, __, ___) {
      return Transform.scale(
        scale: Curves.easeOutBack.transform(animation.value),
        child: Opacity(
          opacity: animation.value,
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.15),
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  // ICON
                  Container(
                    width: 82,
                    height: 82,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xffFF9800),
                          Color(0xffFF5722),
                        ],
                      ),
                    ),
                    child: const Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 42,
                    ),
                  ),

                  const SizedBox(height: 22),

                  // TITLE
                const Text(
  "Logout Account?",
  textAlign: TextAlign.center,
  style: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    decoration: TextDecoration.none,
  ),
),

                  const SizedBox(height: 14),

                  // DESC
                  const Text(
  "Semua progress, poin, reward dan data akan direset ke awal.",
  textAlign: TextAlign.center,
  style: TextStyle(
    fontSize: 16,
    height: 1.5,
    color: Colors.black54,
    decoration: TextDecoration.none,
  ),
),

                  const SizedBox(height: 26),

                  Row(
                    children: [

                      // CANCEL
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Color(0xff7E57C2),
                              width: 1.3,
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff7E57C2),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 14),

                      // LOGOUT
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            Navigator.pop(context);

                            await UserData.reset();

                            if (!mounted) return;

                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SplashPage(),
                              ),
                              (route) => false,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 8,
                            shadowColor:
                                Colors.red.withOpacity(.4),
                            backgroundColor:
                                const Color(0xffF44336),
                            padding:
                                const EdgeInsets.symmetric(
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(18),
                            ),
                          ),
                          child: const Text(
                            "Logout",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

  Widget menuTile(
    IconData icon,
    String title,
    List<Color> colors,
    VoidCallback onTap,
  ) {
    return StatefulBuilder(
      builder:
          (context,
              setLocal) {
        double scale =
            1.0;

        return GestureDetector(
          onTapDown: (_) {
            setLocal(() {
              scale = 0.95;
            });
          },
          onTapUp: (_) {
            setLocal(() {
              scale = 1.0;
            });

            Future.delayed(
              const Duration(
                  milliseconds:
                      80),
              onTap,
            );
          },
          onTapCancel: () {
            setLocal(() {
              scale = 1.0;
            });
          },
          child:
              AnimatedScale(
            duration:
                const Duration(
                    milliseconds:
                        120),
            scale:
                scale,
            child: Container(
              margin:
                  const EdgeInsets.only(
                      bottom:
                          16),
              padding:
                  const EdgeInsets.all(
                      18),
              decoration:
                  BoxDecoration(
                gradient:
                    LinearGradient(
                  colors:
                      colors,
                ),
                borderRadius:
                    BorderRadius.circular(
                        24),
                boxShadow: [
                  BoxShadow(
                    color: colors
                        .first
                        .withOpacity(
                            .35),
                    blurRadius:
                        16,
                    offset:
                        const Offset(
                            0,
                            8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.all(
                            10),
                    decoration:
                        const BoxDecoration(
                      color: Colors
                          .white24,
                      shape: BoxShape
                          .circle,
                    ),
                    child:
                        Icon(
                      icon,
                      color: Colors
                          .white,
                    ),
                  ),
                  const SizedBox(
                      width:
                          14),
                  Expanded(
                    child:
                        Text(
                      title,
                      style:
                          const TextStyle(
                        fontSize:
                            18,
                        color: Colors
                            .white,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons
                        .arrow_forward_ios,
                    color: Colors
                        .white,
                    size: 16,
                  ),
                ],
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
    int level =
        (UserData.totalPoint ~/
                100) +
            1;

    int xp =
        UserData.totalPoint %
            100;

    return Scaffold(
      backgroundColor:
          const Color(
              0xffF6F7FB),
      body: SafeArea(
        child:
            SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double
                    .infinity,
                padding:
                    const EdgeInsets.only(
                  top: 20,
                  left: 22,
                  right: 22,
                  bottom: 34,
                ),
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
                  borderRadius:
                      BorderRadius.only(
                    bottomLeft:
                        Radius.circular(
                            36),
                    bottomRight:
                        Radius.circular(
                            36),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(
                                context);
                          },
                          child:
                              const Icon(
                            Icons
                                .arrow_back_ios_new,
                            color: Colors
                                .white,
                          ),
                        ),
                        const Expanded(
                          child: Center(
                            child:
                                Text(
                              "My Profile",
                              style:
                                  TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap:
                              openSettingSidebar,
                          child:
                              const Icon(
                            Icons
                                .settings,
                            color: Colors
                                .white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                        height:
                            28),
                    CircleAvatar(
                      radius:
                          54,
                      backgroundColor:
                          Colors
                              .white,
                      child:
                          Text(
                        avatars[
                            selectedAvatar],
                        style:
                            const TextStyle(
                          fontSize:
                              48,
                        ),
                      ),
                    ),
                    const SizedBox(
                        height:
                            16),
                    Text(
                      userName,
                      style:
                          const TextStyle(
                        color: Colors
                            .white,
                        fontSize:
                            30,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                    Text(
                      "LEVEL $level HERO",
                      style:
                          const TextStyle(
                        color: Colors
                            .white70,
                      ),
                    ),
                    const SizedBox(
                        height:
                            18),
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(
                              20),
                      child:
                          LinearProgressIndicator(
                        value:
                            xp /
                                100,
                        minHeight:
                            10,
                        backgroundColor:
                            Colors.white24,
                        valueColor:
                            const AlwaysStoppedAnimation(
                          Colors.amber,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.all(
                        18),
                child: Column(
                  children: [
                    menuTile(
                      Icons.person,
                      "Edit Profile",
                      [
                        Colors.blue,
                        Colors.cyan,
                      ],
                      editProfile,
                    ),
                    menuTile(
                      Icons
                          .emoji_events,
                      "Achievements",
                      [
                        Colors.orange,
                        Colors.deepOrange,
                      ],
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const LeaderboardPage(),
                          ),
                        );
                      },
                    ),
                    menuTile(
                      Icons.bar_chart,
                      "Statistics",
                      [
                        Colors.green,
                        Colors.teal,
                      ],
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const ProgressPage(),
                          ),
                        );
                      },
                    ),
                    menuTile(
                      Icons.logout,
                      "Logout",
                      [
                        Colors.red,
                        Colors.pink,
                      ],
                      showLogoutDialog,
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