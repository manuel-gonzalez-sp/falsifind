import 'package:falsifind/config/app_router.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shared_intent_service.g.dart';

@Riverpod(keepAlive: true)
class SharedIntentService extends _$SharedIntentService {
  @override
  Stream<List<SharedMediaFile>> build() async* {
    final initial = await ReceiveSharingIntent.getInitialMedia();
    yield initial;

    yield* ReceiveSharingIntent.getMediaStream();
  }

  Future<void> gotoDetails(List<SharedMediaFile> value) async {
    await ReceiveSharingIntent.reset();
    if (value.isNotEmpty) {
      final data = value.last.path;
      await appRouter.push('/news_details/external', extra: data);
    }
  }
}
