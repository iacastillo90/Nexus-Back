import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'logger_service.dart';

/// 🧠 **Servicio de Inteligencia Artificial Local (Hybrid AI)**
///
/// Gestiona las capacidades cognitivas de la App (Echo).
/// Implementa una estrategia híbrida: Cloud (Gemini Pro) + Local (Heurística).
///
/// **Responsabilidades:**
/// - Generar respuestas inteligentes (Smart Replies) para el chat.
/// - Analizar el sentimiento de textos para el sistema de Vibes.
/// - Proveer fallbacks offline cuando no hay internet o API Key.
///
/// **Referencias:**
/// - API: Google Gemini Pro (`google_generative_ai`).
final localAIServiceProvider = Provider<LocalAIService>((ref) {
  return LocalAIService();
});

/// 🧠 **Clase LocalAIService**
class LocalAIService {
  GenerativeModel? _model;
  bool _isInitialized = false;

  /// 🚀 **Inicializar Motor AI**
  ///
  /// Configura el modelo Gemini Pro con la API Key del entorno.
  /// Debe llamarse al inicio de la app (`main.dart`).
  Future<void> initialize() async {
    if (_isInitialized) return;

    final apiKey = dotenv.env['GEMINI_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      LoggerService.w('⚠️ LocalAIService: GEMINI_API_KEY not found in .env');
      return;
    }

    _model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: apiKey,
    );
    
    _isInitialized = true;
    LoggerService.i('🧠 LocalAIService (Gemini) initialized');
  }

  /// 💬 **Generar Respuestas Inteligentes**
  ///
  /// Crea sugerencias de respuesta rápida basadas en el contexto del chat.
  ///
  /// **Parámetros:**
  /// - [context]: El último mensaje recibido o el historial reciente.
  ///
  /// **Retorno:**
  /// Lista de 3 strings cortos (ej: ["Sí, claro", "No puedo", "Más tarde"]).
  ///
  /// **Estrategia:**
  /// 1. Intenta usar Gemini Pro (Online).
  /// 2. Si falla o está offline, usa [_offlineSmartReplies].
  Future<List<String>> generateSmartReplies(String context) async {
    if (!_isInitialized || _model == null) {
      return _offlineSmartReplies(context);
    }

    try {
      final prompt = 'Generate 3 short, casual, and relevant smart replies for the following message: "$context". Return only the replies separated by |.';
      final content = [Content.text(prompt)];
      final response = await _model!.generateContent(content);
      
      if (response.text != null) {
        return response.text!.split('|').map((e) => e.trim()).toList();
      }
    } catch (e) {
      LoggerService.e('Error generating smart replies: $e');
    }
    
    return _offlineSmartReplies(context);
  }

  /// 🎭 **Analizar Sentimiento**
  ///
  /// Determina la carga emocional de un texto.
  ///
  /// **Parámetros:**
  /// - [text]: El texto a analizar.
  ///
  /// **Retorno:**
  /// String: 'Positive', 'Negative', o 'Neutral'.
  Future<String> analyzeSentiment(String text) async {
    if (!_isInitialized || _model == null) {
      return _offlineSentiment(text);
    }

    try {
      final prompt = 'Analyze the sentiment of this text: "$text". Return only one word: Positive, Negative, or Neutral.';
      final content = [Content.text(prompt)];
      final response = await _model!.generateContent(content);
      
      if (response.text != null) {
        return response.text!.trim();
      }
    } catch (e) {
      LoggerService.e('Error analyzing sentiment: $e');
    }

    return _offlineSentiment(text);
  }

  // --- Offline Fallbacks (Heuristics) ---

  /// 🔌 **Smart Replies Offline (Heurística)**
  ///
  /// Algoritmo simple de coincidencia de palabras clave para cuando no hay IA.
  List<String> _offlineSmartReplies(String context) {
    final lower = context.toLowerCase();
    if (lower.contains('hello') || lower.contains('hi')) {
      return ['Hi there!', 'Hello!', 'Hey!'];
    } else if (lower.contains('how are you')) {
      return ['I am good!', 'Doing great!', 'All good, thanks!'];
    } else if (lower.contains('bye')) {
      return ['See ya!', 'Goodbye!', 'Later!'];
    }
    return ['Interesting.', 'Tell me more.', 'Okay.'];
  }

  /// 🔌 **Sentimiento Offline (Bolsa de Palabras)**
  ///
  /// Cuenta palabras positivas vs negativas para estimar el sentimiento.
  String _offlineSentiment(String text) {
    final lower = text.toLowerCase();
    final positives = ['good', 'great', 'awesome', 'love', 'happy', 'cool'];
    final negatives = ['bad', 'hate', 'sad', 'angry', 'terrible', 'awful'];

    int score = 0;
    for (final word in positives) {
      if (lower.contains(word)) score++;
    }
    for (final word in negatives) {
      if (lower.contains(word)) score--;
    }

    if (score > 0) return 'Positive';
    if (score < 0) return 'Negative';
    return 'Neutral';
  }
}
