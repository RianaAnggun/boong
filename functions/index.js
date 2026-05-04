const functions = require("firebase-functions");
const { GoogleGenerativeAI } = require("@google/generative-ai");

// MASUKKAN API KEY GEMINI KAMU
const genAI = new GoogleGenerativeAI("AIzaSyBnSiOXxJKU9OwroofiQa7uLPCw39srsXA");

exports.mathTutor = functions.https.onRequest(async (req, res) => {
  try {
    const question = req.body.question || "";

    if (!question) {
      return res.status(400).json({
        reply: "Pertanyaan kosong.",
      });
    }

    const model = genAI.getGenerativeModel({
      model: "gemini-1.5-flash",
    });

    const prompt = `
Kamu adalah tutor matematika bernama MathRush AI.

Jawab pertanyaan siswa dengan bahasa Indonesia yang mudah dimengerti.

Jika soal matematika:
- jelaskan langkah demi langkah
- singkat
- jelas
- ramah

Pertanyaan:
${question}
`;

    const result = await model.generateContent(prompt);
    const response = await result.response;
    const text = response.text();

    res.json({
      reply: text,
    });
  } catch (e) {
    res.status(500).json({
      reply: "AI sedang error.",
      error: e.toString(),
    });
  }
});