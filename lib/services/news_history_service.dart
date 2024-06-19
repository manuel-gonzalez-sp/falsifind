import 'dart:convert';

import 'package:falsifind/models/news_item.dart';
import 'package:falsifind/services/web_scraping_service.dart';
import 'package:localstorage/localstorage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:webview_flutter/webview_flutter.dart';

part 'news_history_service.g.dart';

const kHistoryStorageKey = 'news_history';

@Riverpod(keepAlive: true)
class NewsHistoryService extends _$NewsHistoryService {
  @override
  Future<List<NewsItem>> build() async => _loadItems();

  Future<void> removeItem(String id) async {
    final previousState = await future;
    previousState.removeWhere((item) => item.id == id);
    final newState = [...previousState];

    state = AsyncData(newState);
    _saveItems(newState);
  }

  Future<void> addItem(NewsItem item) async {
    final previousState = await future;
    final newState = [item, ...previousState];

    state = AsyncData(newState);
    _saveItems(newState);
  }

  Future<void> updateItem(NewsItem item) async {
    final previousState = await future;
    final index = previousState.indexWhere((item) => item.id == item.id);
    if (index != -1) {
      previousState[index] = item;
    }

    final newState = [...previousState];
    state = AsyncData(newState);
    _saveItems(newState);
  }

  Future<NewsItem?> getItem(String url, WebViewController controller) async {
    final previousState = await future;

    final items = previousState.where((item) => item.url == url);
    if (items.isNotEmpty) {
      return items.first;
    }

    final item = await extractNewsInfoFromWebView(controller);
    if (item != null) {
      final newState = [item, ...previousState];
      state = AsyncData(newState);
      _saveItems(newState);
    }
    return item;
  }

  List<NewsItem> _loadItems() {
    final data = localStorage.getItem(kHistoryStorageKey);
    if (data != null) {
      final items = List<dynamic>.of(jsonDecode(data));
      return items.map((item) => NewsItem.fromJson(item)).toList();
    }
    return [];
  }

  void _saveItems(List<NewsItem> items) {
    final data = jsonEncode(items);
    localStorage.setItem(kHistoryStorageKey, data);
  }
}
