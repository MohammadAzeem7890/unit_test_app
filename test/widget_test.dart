// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:unit_testing_app/home_cubit.dart';

import 'package:unit_testing_app/main.dart';
import 'package:unit_testing_app/post_model.dart';



void main() {
  late HomeCubit homeCubit;


  setUp(() {
    homeCubit = HomeCubit();
  });

  group("asdf", () {
    test("asdklfjas", () {
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

    test("test success", () async {
      // arrange

      // activate
      final value = await homeCubit.getPosts();


      // assert
      expect(value, isA<List<PostModel>?>());
    });

    test("expect null", () async {
      // arrange

      // activate
      final value = await homeCubit.getPosts();


      // assert
      expect(value, null);
    });


  });
}
