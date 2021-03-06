import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getinstasample/constant/story_json.dart';
import 'package:getinstasample/httpservice/httpsservices.dart';
import 'package:getinstasample/model/getPost.dart';
import 'package:getinstasample/widgets/story_item.dart';

import '../theme/colors.dart';
import '../widgets/post_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Posts> _posts = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInstaPosts();
  }

  getInstaPosts() async {
    Response response = await HttpService.hGet(
        "https://li3bzg1xs9.execute-api.ap-south-1.amazonaws.com/default/getInstaPosts");
    if (response.statusCode == 200) {
      var data = response.data;
      var posts = data["posts"];
      for (var post in posts) {
        _posts.add(Posts.fromJson(post));
      }
      setState(() {});
    }
    print(_posts.length);
  }

  @override
  Widget build(BuildContext context) {
    return getBody();
  }

  Widget getBody() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(right: 20, left: 15, bottom: 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 65,
                        height: 65,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              width: 65,
                              height: 65,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(profile),
                                      fit: BoxFit.cover)),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 19,
                                  height: 19,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle, color: white),
                                  child: Icon(
                                    Icons.add_circle,
                                    color: buttonFollowColor,
                                    size: 19,
                                  ),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: 70,
                        child: Text(
                          name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: white),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                    children: List.generate(stories.length, (index) {
                  return StoryItem(
                    img: stories[index]['img'],
                    name: stories[index]['name'],
                  );
                })),
              ],
            ),
          ),
          Divider(
            color: white.withOpacity(0.3),
          ),
          Column(
            children: List.generate(_posts.length, (index) {
              return PostItem(
                postImg: _posts[index].images[0],
                profileImg: _posts[index].profileImage,
                name: _posts[index].postedBy,
                caption: _posts[index].description,
                isLoved: true,
                viewCount: _posts[index].interactions.likes.toString(),
                likedBy: _posts[index].interactions.likes.toString(),
                dayAgo: "1 day ago",
              );
            }),
          )
        ],
      ),
    );
  }
}
