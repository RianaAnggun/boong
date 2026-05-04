import 'package:flutter/material.dart';
import '../services/gemini_service.dart';

class AiChatPage extends StatefulWidget {
  const AiChatPage({super.key});

  @override
  State<AiChatPage> createState() => _AiChatPageState();
}

class _AiChatPageState extends State<AiChatPage> {

  @override
  void initState() {
    super.initState();
  }

  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  bool loading = false;

  final List<Map<String, dynamic>> messages = [
    {
      "isUser": false,
      "text":
          "Halo 👋 Aku MathRush AI Tutor.\nTanyakan soal matematika apa saja!"
    }
  ];

  final List<Map<String, String>> history = [];

  // 🔥 ambil model (debug)
  Future<void> loadModels() async {
    final result = await GeminiService.listModels();

    if (!mounted) return;

    setState(() {
      messages.add({
        "isUser": false,
        "text": result,
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  Future<void> sendMessage() async {
    if (controller.text.trim().isEmpty || loading) return;

    final String text = controller.text.trim();

    setState(() {
      messages.add({
        "isUser": true,
        "text": text,
      });
      loading = true;
    });

    controller.clear();
    scrollDown();

    history.add({
      "role": "user",
      "text": text,
    });

    try {
      final String reply = await GeminiService.ask(history);

      history.add({
        "role": "model",
        "text": reply,
      });

      if (!mounted) return;

      setState(() {
        messages.add({
          "isUser": false,
          "text": reply,
        });
        loading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        messages.add({
          "isUser": false,
          "text": "Terjadi kesalahan.",
        });
        loading = false;
      });
    }

    scrollDown();
  }

  void scrollDown() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget bubble(String text, bool isUser) {
    return Align(
      alignment:
          isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: isUser
              ? const LinearGradient(
                  colors: [
                    Color(0xff00C6FF),
                    Color(0xff0072FF),
                  ],
                )
              : const LinearGradient(
                  colors: [
                    Color(0xff7F00FF),
                    Color(0xffE100FF),
                  ],
                ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            height: 1.45,
          ),
        ),
      ),
    );
  }

  Widget typingBubble() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: Colors.white10,
        ),
        child: const Text(
          "🤖 sedang mengetik...",
          style: TextStyle(
            color: Colors.white70,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0B1020),
      body: SafeArea(
        child: Column(
          children: [

            /// HEADER
            Container(
              padding: const EdgeInsets.all(18),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff00C6FF),
                    Color(0xff7F00FF),
                  ],
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.15),
                    ),
                    child: const Center(
                      child: Text(
                        "🤖",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          "MathRush AI Tutor",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          "Smart Math Assistant",
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// CHAT AREA
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.all(16),
                itemCount:
                    messages.length + (loading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (loading &&
                      index == messages.length) {
                    return typingBubble();
                  }

                  return bubble(
                    messages[index]["text"],
                    messages[index]["isUser"],
                  );
                },
              ),
            ),

            /// INPUT AREA
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.25),
              ),
              child: Row(
                children: [

                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius:
                            BorderRadius.circular(24),
                      ),
                      child: TextField(
                        controller: controller,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        minLines: 1,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          hintText: "Tanya matematika...",
                          hintStyle: TextStyle(
                            color: Colors.white38,
                          ),
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 14,
                          ),
                        ),
                        onSubmitted: (_) => sendMessage(),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  GestureDetector(
                    onTap:
                        loading ? null : sendMessage,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff00C6FF),
                            Color(0xff7F00FF),
                          ],
                        ),
                      ),
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}