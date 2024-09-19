import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:unit_testing_app/home.dart';
import 'package:unit_testing_app/home_network.dart';
import 'package:unit_testing_app/login_cubit.dart';
import 'package:unit_testing_app/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;

  late final TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(color: Colors.deepPurple));

  final errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(color: Colors.red));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Login",
              style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 30,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 40,
            ),
            TextField(
              controller: _emailController,
              style: const TextStyle(color: Colors.deepPurple),
              decoration: InputDecoration(
                  border: border,
                  hintStyle: const TextStyle(color: Colors.deepPurple),
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: Colors.deepPurple,
                  ),
                  enabledBorder: border,
                  errorBorder: errorBorder,
                  hintText: "Email"),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                  border: border,
                  prefixIcon: const Icon(
                    Icons.lock_open_sharp,
                    color: Colors.deepPurple,
                  ),
                  enabledBorder: border,
                  errorBorder: errorBorder,
                  hintText: "Password"),
            ),
            const SizedBox(
              height: 30,
            ),
            BlocConsumer<LoginCubit, LoginState>(
                builder: (BuildContext context, LoginState state) {
              if (state is LoginLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is LoginFailed) {
                return const Center(
                  child: Text("Login Failed"),
                );
              }
              return Container();
            }, listener: (context, state) {
              if (state is LoginSuccess) {}
            }),
            const SizedBox(
              height: 30,
            ),
            BlocConsumer<LoginCubit, LoginState>(
                builder: (BuildContext context, LoginState state) {
              if (state is LoginLoading) {
                return Container();
              }
              return Center(
                child: ElevatedButton(
                    onPressed: () {
                      final loginCubit = context.read<LoginCubit>();
                      loginCubit.login(
                          _emailController.text, _passwordController.text);
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.deepPurple),
                    )),
              );
            }, listener: (context, state) {
              if (state is LoginSuccess) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Home(
                        futureListOfPosts:
                            HomeNetwork(Client()).fetchPosts())));
              }
            }),
          ],
        ),
      ),
    );
  }
}
