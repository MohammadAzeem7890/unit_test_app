import 'package:flutter/material.dart';
import 'package:unit_testing_app/home_cubit.dart';
import 'package:unit_testing_app/post_model.dart';

class Home extends StatefulWidget {
  final Future<List<PostModel>> futureListOfPosts;
  const Home({super.key, required this.futureListOfPosts});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeCubit _cubit = HomeCubit();

  incrementCounter() {
    setState(() {
      _cubit.incrementCounter();
    });
  }

  decrementCounter() {
    setState(() {
      _cubit.decrementCounter();
    });
  }

  resetCounter() {
    setState(() {
      _cubit.resetCounter();
    });
  }

  refreshList() async {
    await widget.futureListOfPosts;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Home"),
      ),
      body: FutureBuilder(
        future: widget.futureListOfPosts,
        builder: (context, AsyncSnapshot<List<PostModel>?> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  PostModel post = snapshot.data![index];
                  if (snapshot.data!.isEmpty) {
                    return const Text("Empty list");
                  }
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                blurStyle: BlurStyle.outer,
                                blurRadius: 6,
                                spreadRadius: 0,
                                offset: const Offset(0, 0),
                                color: Colors.black12.withOpacity(0.1))
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: ListTile(
                          title: Text(
                            post.title.toString().replaceAll("\n", ''),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            post.body.toString(),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
              "${snapshot.error}",
              textAlign: TextAlign.center,
            ));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              key: const Key("increment_counter"),
              onPressed: incrementCounter,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
            FloatingActionButton(
              key: const Key("decrement_counter"),
              onPressed: decrementCounter,
              tooltip: 'Decrement',
              child: const Icon(Icons.minimize),
            ),
            FloatingActionButton(
              key: const Key("reset_counter"),
              onPressed: resetCounter,
              tooltip: 'Reset',
              child: const Icon(Icons.lock_reset_outlined),
            )
          ],
        ),
      ),
    );
  }
}
