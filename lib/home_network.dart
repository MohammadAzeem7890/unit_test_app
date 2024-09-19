import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:unit_testing_app/post_model.dart';

class HomeNetwork {
  final http.Client httpClient;

  HomeNetwork(this.httpClient);

  // Base URL
  static const String baseUrl = "https://jsonplaceholder.typicode.com";

  // Function to fetch posts
  Future<List<PostModel>> fetchPosts() async {
    try {
      // Make HTTP GET request
      final response = await httpClient.get(
        Uri.parse("$baseUrl/posts"),
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Decode the JSON response
        List<dynamic> jsonData = jsonDecode(response.body);

        // Convert the JSON into a List<PostModel>
        List<PostModel> posts = PostModel.fromJsonList(jsonData);

        return posts; // Return the list of posts
      } else {
        // If the request fails, throw an error
        throw Exception("Failed to load posts");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
