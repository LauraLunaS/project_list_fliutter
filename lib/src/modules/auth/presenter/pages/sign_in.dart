import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:project_list_fliutter/src/modules/auth/presenter/stores/sign_in_store.dart';
import 'package:window_manager/window_manager.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with WindowListener {
  late final FormStore formStore;

  @override
  void initState() {
    super.initState();
    formStore = context.read<FormStore>();
    formStore.errorMessage = '';

    reaction(
      (_) => formStore.isLogged,
      (isLogged) {
        if (isLogged) {
          final userId = formStore.loggedUser?.id;
          if (userId != null) {
            Modular.to.navigate('/tasks/',
                arguments: {'userId': formStore.loggedUser?.id});
          }
        }
      },
    );

    reaction(
      (_) => formStore.navigatePage,
      (navigate) {
        if (navigate) {
          Modular.to.navigate('/sign_up');
          formStore.navigatePage = false;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 500,
          height: 500,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color.fromARGB(85, 17, 16, 56),
            borderRadius: BorderRadius.circular(22),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Welcome to back',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Text(
                'Login',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              Observer(
                builder: (_) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (formStore.errorMessage.isNotEmpty)
                        Text(
                          formStore.errorMessage,
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      const SizedBox(height: 30),
                      TextField(
                        decoration: const InputDecoration(
                            labelText: 'Username',
                            labelStyle:
                                TextStyle(color: Colors.white, fontSize: 14)),
                        onChanged: formStore.setUsername,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      TextField(
                        decoration: const InputDecoration(
                            labelText: 'Password',
                            labelStyle:
                                TextStyle(color: Colors.white, fontSize: 14)),
                        obscureText: true,
                        onChanged: formStore.setPassword,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 40),
                      OutlinedButton(
                        onPressed: () async {
                          await formStore.doLogin();
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor:
                              const Color.fromARGB(255, 0, 71, 129),
                          side: const BorderSide(
                            color: Color.fromARGB(255, 0, 71, 129),
                            width: 2,
                          ),
                        ),
                        child: formStore.isLoading
                            ? const CircularProgressIndicator()
                            : const Text('Sign In'),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          formStore.linkToPage();
                        },
                        child: const Text(
                          'Don\'t have an account? Sign Up',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
