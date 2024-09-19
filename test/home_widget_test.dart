import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unit_testing_app/home.dart';
import 'package:unit_testing_app/home_network.dart';
import 'package:unit_testing_app/post_model.dart';

class MockPostListModelForWidgetTesting extends Mock implements Client {}

void main() {
  const String baseUrl = "https://jsonplaceholder.typicode.com";

  late MockPostListModelForWidgetTesting modelForWidgetTesting;
  late HomeNetwork homeNetwork;

  setUp(() {
    modelForWidgetTesting = MockPostListModelForWidgetTesting();
    homeNetwork = HomeNetwork(modelForWidgetTesting);
  });

  testWidgets('description', (tester) async {
    List<PostModel> posts = [
      PostModel(
          id: 3,
          userId: 1,
          title: "first model",
          body: "asdf asd fasdf asd fas"),
      PostModel(
          id: 4,
          userId: 2,
          title: "second model",
          body: "s dfasdf asdf asd fasd fas"),
      PostModel(
          id: 5,
          userId: 3,
          title: "thrid omod",
          body: "as sdaf sdf asdfa sd fdfasd fasdf asd fa"),
    ];

    Future<List<PostModel>> getFuturePosts() async {
      return posts;
    }

    when(() {
      return modelForWidgetTesting.get(Uri.parse("$baseUrl/posts"));
    }).thenAnswer((_) async {
      return Response('''
    [   {
    "userId": 1,
    "id": 3,
    "title": "first model",
    "body": "asdf asd fasdf asd fas"
  },
  {
    "userId": 1,
    "id": 3,
    "title": "second model",
    "body": "s dfasdf asdf asd fasd fas"
  },
  {
    "userId": 1,
    "id": 3,
    "title": "thrid omod",
    "body": "as sdaf sdf asdfa sd fdfasd fasdf asd fa"
  }
  ]
      ''', 200);
    });

    await tester.pumpWidget(MaterialApp(
        home: Home(
      futureListOfPosts: homeNetwork.fetchPosts(),
    )));

    final findCircularProgressBar = find.byType(CircularProgressIndicator);
    expect(findCircularProgressBar, findsOne);

    await tester.pumpAndSettle();
    //
    final findListView = find.byType(ListView);
    expect(findListView, findsOne);

    final findListTiles = find.byType(ListTile);
    expect(findListTiles, findsNWidgets(posts.length));

    for (final post in posts) {
      expect(find.text(post.title), findsOneWidget,
          reason: "expect ${post.title}");
      expect(find.text(post.body), findsOneWidget,
          reason: "expect: ${post.body}");
    }

    final findAllButtons = find.byType(FloatingActionButton);
    expect(findAllButtons, findsWidgets);

    //
    final findAllButtonsByType = find.byType(FloatingActionButton);
    expect(findAllButtonsByType, findsWidgets);
    //
    final findHome = find.text("Home");
    expect(findHome, findsOne);
    //
    final findAppBar = find.byType(AppBar);
    expect(findAppBar, findsOne);
    //
    final findIncrementButton = find.byKey(const Key("increment_counter"));
    expect(findIncrementButton, findsOne);
    //
    final findDecrementButton = find.byKey(const Key("decrement_counter"));
    expect(findDecrementButton, findsOne);
    //
    final findResetButton = find.byKey(const Key("reset_counter"));
    expect(findResetButton, findsOne);

    //
    // verify(() => homeNetwork.fetchPosts()).called(1);
  });
}
