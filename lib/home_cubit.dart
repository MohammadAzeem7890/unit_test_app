import 'dart:io';

import 'package:flutter/animation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:unit_testing_app/home_network.dart';
import 'package:unit_testing_app/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unit_testing_app/post_model.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  int _counter = 0;

  final HomeNetwork _homeNetwork = HomeNetwork(Client());

  Future<List<PostModel>> getPosts() async {
    try {
      return await _homeNetwork.fetchPosts();
    } catch (e) {
      print("this is exception: $e");
      throw Exception(e);
    }
  }

  int get getCounter => _counter;

  incrementCounter() {
    _counter++;
  }

  decrementCounter() {
    _counter--;
  }

  resetCounter() {
    _counter *= 0;
  }
}
