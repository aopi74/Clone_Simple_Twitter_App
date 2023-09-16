import 'package:flutter/material.dart';

import '../data/datasources/tweet_datasource.dart';
import '../data/models/tweet_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _nameTextEditingController = TextEditingController();
  TextEditingController _tweetTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                            height: 400,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: _nameTextEditingController,
                                    decoration:
                                        const InputDecoration(hintText: "Name"),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: _tweetTextEditingController,
                                    decoration:
                                        InputDecoration(hintText: "Your Tweet"),
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: () async {
                                      String name =
                                          _nameTextEditingController.text;
                                      String tweet =
                                          _tweetTextEditingController.text;

                                      await TweetDatasource.postTweet(
                                        TweetModel(writter: name, tweet: tweet),
                                      );
                                    },
                                    child: Text("Post")),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Text("Post a Tweet")),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        print("refresh pressed");
                        setState(() {});
                      },
                      child: Text("Refresh")),
                )
              ],
            )),
        Expanded(
          flex: 10,
          child: FutureBuilder(
            future: TweetDatasource.getAllTweets(),
            builder: (BuildContext context, AsyncSnapshot sn) {
              if (sn.hasError) {
                return Text("Error Loading Data ${sn.error}");
              }
              if (sn.hasData) {
                List<TweetModel> tweets = sn.data;
                return ListView.builder(
                    itemCount: tweets.length,
                    itemBuilder: (BuildContext context, int index) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage("https://i.pravatar.cc/300"),
                          ),
                          title: Text("${tweets[index].writter}"),
                          subtitle: Text("${tweets[index].tweet}"),
                        ));
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }
}
