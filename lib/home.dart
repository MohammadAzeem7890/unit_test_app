import 'package:flutter/material.dart';
import 'package:unit_testing_app/home_cubit.dart';
import 'package:unit_testing_app/post_model.dart';

class Home extends StatefulWidget {
  final Future<List<PostModel>> futureListOfPosts;
  const Home({super.key, required this.futureListOfPosts});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final HomeCubit _cubit = HomeCubit();
  late final AnimationController _animatedContainer;
  late final Animation<double> _widthAnimation;
  late final Animation<Color?> _colorAnimation;
  late final Animation<double> _borderRadiusAnimation;

  @override
  void initState() {
    _animatedContainer =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _widthAnimation = Tween<double>(begin: 0, end: 200).animate(
        CurvedAnimation(parent: _animatedContainer, curve: Curves.easeInOut));
    _colorAnimation = ColorTween(begin: Colors.blue, end: Colors.green).animate(
        CurvedAnimation(parent: _animatedContainer, curve: Curves.easeInCubic));
    _borderRadiusAnimation = Tween<double>(begin: 0, end: 50).animate(
        CurvedAnimation(parent: _animatedContainer, curve: Curves.easeInOut));

    // start the animation
    _animatedContainer.forward();

    super.initState();
  }

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
  void dispose() {
    _animatedContainer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Home"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              AnimatedBuilder(
                  animation: _animatedContainer,
                  builder: (context, child) {
                    return Container(
                      key: const Key("animation_container"),
                      height: _widthAnimation.value,
                      width: _widthAnimation.value,
                      decoration: BoxDecoration(
                        color: _colorAnimation.value,
                        borderRadius:
                            BorderRadius.circular(_borderRadiusAnimation.value),
                      ),
                    );
                  }),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Following is counter value: \n ${_cubit.getCounter.toString()}",
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: widget.futureListOfPosts,
                builder: (context, AsyncSnapshot<List<PostModel>?> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          PostModel post = snapshot.data![index];
                          if (snapshot.data!.isEmpty) {
                            return const Text("Empty list");
                          }
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 15),
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
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
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
            ],
          ),
        ),
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
