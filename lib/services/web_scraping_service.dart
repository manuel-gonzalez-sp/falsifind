import 'dart:convert';

import 'package:falsifind/models/news_item.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:webview_flutter/webview_flutter.dart';

Future<NewsItem?> extractNewsInfo(String url) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    var document = parse(response.body);

    // Extract title
    String title = document.querySelector('title')?.text ?? 'No title found';

    // Extract content within article tag
    Element? article = document.querySelector('article');
    String content = 'No content found';
    if (article != null) {
      List<Element> paragraphs = article.querySelectorAll('p');
      content = paragraphs.map((e) => e.text).join(' ');
    }

    // Extract date
    String date = 'No date found';
    List<String> datePatterns = ['meta[property="article:published_time"]', 'meta[name="publish_date"]', 'meta[name="date"]'];
    for (var pattern in datePatterns) {
      var dateTag = document.querySelector(pattern);
      if (dateTag != null && dateTag.attributes.containsKey('content')) {
        date = dateTag.attributes['content']!;
        break;
      }
    }

    // Extract cover URL
    String coverUrl = 'No cover URL found';
    var ogImageTag = document.querySelector('meta[property="og:image"]');
    if (ogImageTag != null && ogImageTag.attributes.containsKey('content')) {
      coverUrl = ogImageTag.attributes['content']!;
    } else {
      List<Element> images = document.querySelectorAll('img');
      if (images.isNotEmpty) {
        coverUrl = images.first.attributes['src']!;
      }
    }

    return NewsItem(
      id: const Uuid().v6(),
      title: title,
      content: content,
      url: url,
      consultationDate: DateTime.now(),
      date: DateTime.tryParse(date),
      coverUrl: Uri.tryParse(coverUrl)?.toString(),
    );
  }

  return null;
}

Future<NewsItem?> extractNewsInfoFromWebView(WebViewController controller) async {
  final data = await controller.runJavaScriptReturningResult('''
        (function() {
          var result = {};

          // Extract title
          var title = document.querySelector('title')?.textContent || 'No title found';
          result.title = title;

          // Extract content within article tag
          var article = document.querySelector('article');
          var content = 'No content found';
          if (article) {
            var paragraphs = article.querySelectorAll('p');
            content = Array.from(paragraphs).map(p => p.textContent).join(' ');
          }
          result.content = content;

          // Extract date
          var datePatterns = ['meta[property="article:published_time"]', 'meta[name="publish_date"]', 'meta[name="date"]'];
          var date = 'No date found';
          for (var pattern of datePatterns) {
            var dateTag = document.querySelector(pattern);
            if (dateTag && dateTag.content) {
              date = dateTag.content;
              break;
            }
          }
          result.date = date;

          // Extract cover URL
          var coverUrl = 'No cover URL found';
          var ogImageTag = document.querySelector('meta[property="og:image"]');
          if (ogImageTag && ogImageTag.content) {
            coverUrl = ogImageTag.content;
          } else {
            var images = document.querySelectorAll('img');
            if (images.length > 0) {
              coverUrl = images[0].src;
            }
          }
          result.coverUrl = coverUrl;
         
          return result;
        })()
        ''');

  final result = jsonDecode(data as String);
  final url = await controller.currentUrl();

  return NewsItem(
    id: const Uuid().v6(),
    url: url!,
    title: result['title'],
    content: result['content'],
    date: DateTime.tryParse(result['date']),
    coverUrl: Uri.tryParse(result['coverUrl'])?.toString(),
    consultationDate: DateTime.now(),
  );
}
