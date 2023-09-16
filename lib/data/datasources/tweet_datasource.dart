import 'dart:convert';
import 'package:clone_simple_twite_app/data/models/tweet_model.dart';
import 'package:http/http.dart' as http;

class TweetDatasource {
  static Future<List<TweetModel>> getAllTweets() async {
    List<TweetModel> tweetList = [];

    http.Response response = await http
        .get(Uri.parse("https://65046c29c8869921ae250591.mockapi.io/tweet"));

    if (response.statusCode == 200) {
      List parsedJson = jsonDecode(response.body);

      parsedJson.forEach((tweet) {
        tweetList.add(TweetModel.fromJson(tweet));
      });
    }
    return tweetList;
  }

  static Future<bool> postTweet(TweetModel tweetModel) async {
    http.Response response = await http.post(
      Uri.parse("https://65046c29c8869921ae250591.mockapi.io/tweet"),
      body: tweetModel.toJson(),
    );

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }
}
