// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unit_testing_app/home_cubit.dart';
import 'package:unit_testing_app/home_network.dart';

import 'package:unit_testing_app/main.dart';
import 'package:unit_testing_app/post_model.dart';

class MockHTTPClient extends Mock implements Client {}

void main() {
  late MockHTTPClient mockHTTPClient;
  late HomeNetwork homeNetwork;
  late HomeCubit homeCubit;

  const String baseUrl = "https://jsonplaceholder.typicode.com";

  setUp(() {
    mockHTTPClient = MockHTTPClient();
    homeCubit = HomeCubit();
    homeNetwork = HomeNetwork(mockHTTPClient);
  });

  group("asdf", () {
    test("check counter initial value", () {
      // arrange

      // activate
      final value = homeCubit.getCounter;

      // assert
      expect(value, 0);
    });

    test("asdklfjas", () {
      // arrange

      // activate
      homeCubit.incrementCounter();
      final value = homeCubit.getCounter;

      // assert
      expect(value, 1);
    });

    test("asdklfjas", () {
      // arrange

      // activate
      homeCubit.decrementCounter();
      final value = homeCubit.getCounter;

      // assert
      expect(value, -1);
    });

    test("asdklfjas", () {
      // arrange

      // activate
      homeCubit.resetCounter();
      final value = homeCubit.getCounter;

      // assert
      expect(value, 0);
    });

    test("test status code 200", () async {
      // arrange
      when(() {
        return mockHTTPClient.get(Uri.parse("$baseUrl/posts"));
      }).thenAnswer((_) async {
        return Response('''
            [
  {
    "userId": 1,
    "id": 3,
    "title": "ea molestias quasi exercitationem repellat qui ipsa sit aut",
    "body": "et iusto sed quo iur evoluptatem occaecati omnis eligendi aut ad voluptatem doloribus vel accusantium quis pariatur molestiae porro eius odio et labore et velit aut"
  },
  {
    "userId": 1,
    "id": 3,
    "title": "ea molestias quasi exercitationem repellat qui ipsa sit aut",
    "body": "et iusto sed quo iur evoluptatem occaecati omnis eligendi aut ad voluptatem doloribus vel accusantium quis pariatur molestiae porro eius odio et labore et velit aut"
  },
  {
    "userId": 1,
    "id": 3,
    "title": "ea molestias quasi exercitationem repellat qui ipsa sit aut",
    "body": "et iusto sed quo iur evoluptatem occaecati omnis eligendi aut ad voluptatem doloribus vel accusantium quis pariatur molestiae porro eius odio et labore et velit aut"
  }
  ]
            ''', 200);
      });

      // activate
      final posts = await homeNetwork.fetchPosts();

      // assert
      expect(posts, isA<List<PostModel>>());
    });

    test("status code 500", () {
      // arrange
      when(() {
        return mockHTTPClient.get(Uri.parse("$baseUrl/posts"));
      }).thenAnswer((_) async {
        return Response("{}", 500);
      });
      // activate
      final value = homeNetwork.fetchPosts();
      // assert
      expect(value, throwsException);
    });

    test("status code 400", () async {
      // arrange
      when(() {
        return mockHTTPClient.get(Uri.parse("$baseUrl/posts"));
      }).thenAnswer((_) async {
        return Response("{}", 500);
      });
      // activate
      final value = homeNetwork.fetchPosts();
      // assert
      expect(value, throwsException);
    });
  });
}
