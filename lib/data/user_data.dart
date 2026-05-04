import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  static String username = "Player";
  static String avatar = "🐼";

  static int totalPoint = 0;
  static int diamond = 0;
  static int energy = 5;

  static int addProgress = 0;
  static int subProgress = 0;
  static int mulProgress = 0;

  static bool dailyClaimed = false;
  static int loginDay = 1;
  static String lastRewardDate = "";

  static List<int> quizHistory = [];

  static bool isLogin = false;
static String password = "";

  // LOAD DATA
  static Future<void> loadData() async {
    final prefs =
        await SharedPreferences
            .getInstance();

    username =
        prefs.getString(
              "username",
            ) ??
            "Player";

    avatar =
        prefs.getString(
              "avatar",
            ) ??
            "🐼";

    totalPoint =
        prefs.getInt(
              "totalPoint",
            ) ??
            0;

    diamond =
        prefs.getInt(
              "diamond",
            ) ??
            0;

    energy =
        prefs.getInt(
              "energy",
            ) ??
            5;

    addProgress =
        prefs.getInt(
              "addProgress",
            ) ??
            0;

    subProgress =
        prefs.getInt(
              "subProgress",
            ) ??
            0;

    mulProgress =
        prefs.getInt(
              "mulProgress",
            ) ??
            0;

    dailyClaimed =
        prefs.getBool(
              "dailyClaimed",
            ) ??
            false;

    loginDay =
        prefs.getInt(
              "loginDay",
            ) ??
            1;

    lastRewardDate =
        prefs.getString(
              "lastRewardDate",
            ) ??
            "";

            isLogin = prefs.getBool("isLogin") ?? false;
password = prefs.getString("password") ?? "";

    quizHistory =
        prefs
            .getStringList(
              "quizHistory",
            )
            ?.map(
              (e) =>
                  int.tryParse(e) ??
                  0,
            )
            .toList() ??
        [];
  }

  // SAVE DATA
  static Future<void> saveData() async {
    final prefs =
        await SharedPreferences
            .getInstance();

    await prefs.setString(
      "username",
      username,
    );

    await prefs.setString(
      "avatar",
      avatar,
    );

    await prefs.setInt(
      "totalPoint",
      totalPoint,
    );

    await prefs.setInt(
      "diamond",
      diamond,
    );

    await prefs.setInt(
      "energy",
      energy,
    );

    await prefs.setInt(
      "addProgress",
      addProgress,
    );

    await prefs.setInt(
      "subProgress",
      subProgress,
    );

    await prefs.setInt(
      "mulProgress",
      mulProgress,
    );

    await prefs.setBool(
      "dailyClaimed",
      dailyClaimed,
    );

    await prefs.setInt(
      "loginDay",
      loginDay,
    );

    await prefs.setString(
      "lastRewardDate",
      lastRewardDate,
    );

    await prefs.setBool("isLogin", isLogin);
await prefs.setString("password", password);

    await prefs.setStringList(
      "quizHistory",
      quizHistory
          .map(
            (e) =>
                e.toString(),
          )
          .toList(),
    );
  }

  // RESET DATA
 static Future<void> reset() async {
  final prefs =
      await SharedPreferences
          .getInstance();

  await prefs.clear();

  username = "Player";
  avatar = "🐼";

  totalPoint = 0;
  diamond = 0;
  energy = 5;

  addProgress = 0;
  subProgress = 0;
  mulProgress = 0;

  dailyClaimed = false;
  loginDay = 1;
  lastRewardDate = "";

  quizHistory = [];

  await saveData();
}
}