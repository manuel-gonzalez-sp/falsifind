import 'package:flutter_sharing_intent/flutter_sharing_intent.dart';
import 'package:flutter_sharing_intent/model/sharing_file.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sharing_intent_service.g.dart';

@Riverpod(keepAlive: true)
class SharingIntentService extends _$SharingIntentService {
  @override
  Stream<List<SharedFile>> build() => FlutterSharingIntent.instance.getMediaStream();
}
