import 'dart:convert';
import 'dart:developer';

import 'package:bloc_api_noteapp/model/post_model.dart';
import 'package:http/http.dart' as http;

class ApiCalls {
  static String baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<PostModel>> fetchAllPost() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final postsList = jsonDecode(response.body) as List<dynamic>;
        List<PostModel> posts = [];
        for (int i = 0; i < postsList.length; i++) {
          final post = PostModel.fromJson(postsList[i] as Map<String, dynamic>);
          posts.add(post);
        }
        return posts;
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<bool> addPost(PostModel post) async {
    Map<String, dynamic> data = {
      'title': post.title,
      'body': post.body,
      'userId': '20'
    };

    try {
      final response = await http.post(Uri.parse(baseUrl), body: data);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('data inserted successfully');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
