import 'dart:typed_data';

import 'package:falsifind/models/news_item.dart';
import 'package:flutter/widgets.dart';
import 'package:mediapipe_text/mediapipe_text.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'news_classification_service.g.dart';

@Riverpod(keepAlive: true)
class NewsClassificationService extends _$NewsClassificationService {
  @override
  FutureOr<TextClassifier?> build() async {
    return null;
  }

  Future<void> loadModel(BuildContext context) async {
    final previousState = await future;

    if (previousState == null) {
      ByteData? classifierBytes = await DefaultAssetBundle.of(context).load('assets/models/finetuned-mobilebert.tflite');

      final classifier = TextClassifier(
        TextClassifierOptions.fromAssetBuffer(
          classifierBytes.buffer.asUint8List(),
        ),
      );

      state = AsyncData(classifier);
    }
  }

  Future<double?> makeClassification(NewsItem item) async {
    final previousState = await future;

    if (previousState != null) {
      final result = await previousState.classify(item.content);
      return result.firstClassification!.firstCategory!.score;
    }
    return null;
  }
}
