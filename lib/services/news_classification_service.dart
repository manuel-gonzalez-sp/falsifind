import 'package:falsifind/models/news_item.dart';
import 'package:flutter/services.dart';
import 'package:mediapipe_text/mediapipe_text.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:translator/translator.dart';

part 'news_classification_service.g.dart';

@Riverpod(keepAlive: true)
class NewsClassificationService extends _$NewsClassificationService {
  @override
  FutureOr<TextClassifier?> build() async => null;

  Future<void> init() async {
    final model = await rootBundle.load('assets/models/finetuned-mobilebert.tflite');
    final classifier = TextClassifier(
      TextClassifierOptions.fromAssetBuffer(
        model.buffer.asUint8List(),
      ),
    );
    state = AsyncData(classifier);
  }

  Future<double?> classify(NewsItem item) async {
    final previousState = await future;

    if (previousState != null) {
      final translator = GoogleTranslator();

      String content = item.content;
      final translation = await translator.translate(item.content, to: 'en');
      if (translation.sourceLanguage.code != 'en') {
        content = translation.text;
      }

      final result = await previousState.classify(content);
      return result.firstClassification!.firstCategory!.score;
    }
    return null;
  }
}
