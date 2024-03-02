import 'dart:convert';

import 'package:http/http.dart' as http;

class MarketNews {
  final String title;
  final String description;
  final String imageUrl;
  final String url;

  MarketNews({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.url,
  });
}

class MarketNewsService {
  final String apiUrl =
      'https://api.marketaux.com/v1/news/all?&language=en&coutnry=in&api_token=QkS3j9sKk1RHGTXubGBPkywOirjVE7yxElNPYi2v';

  Future<List<MarketNews>> fetchNews() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> newsData = data['data'];

      List<MarketNews> newsList = newsData.map((item) {
        return MarketNews(
          title: item['title'],
          description: item['description'],
          imageUrl: item['image_url'],
          url: item['url'],
        );
      }).toList();

      return newsList;
    } else {
      throw Exception('Failed to load news');
    }
  }
}
