// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_history_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$newsHistoryServiceHash() =>
    r'8edad1f42174e94b99d7528601cf8db37de87600';

/// See also [NewsHistoryService].
@ProviderFor(NewsHistoryService)
final newsHistoryServiceProvider =
    AsyncNotifierProvider<NewsHistoryService, List<NewsItem>>.internal(
  NewsHistoryService.new,
  name: r'newsHistoryServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$newsHistoryServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NewsHistoryService = AsyncNotifier<List<NewsItem>>;
String _$newsHistoyFilteredHash() =>
    r'a5eb545fade45f9891cb7ba0c3cd1d9d5967a2e4';

/// See also [NewsHistoyFiltered].
@ProviderFor(NewsHistoyFiltered)
final newsHistoyFilteredProvider = AutoDisposeAsyncNotifierProvider<
    NewsHistoyFiltered, List<NewsItem>>.internal(
  NewsHistoyFiltered.new,
  name: r'newsHistoyFilteredProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$newsHistoyFilteredHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NewsHistoyFiltered = AutoDisposeAsyncNotifier<List<NewsItem>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
