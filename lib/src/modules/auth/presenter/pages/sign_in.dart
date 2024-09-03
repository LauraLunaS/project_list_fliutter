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
            Modular.to.navigate('/tasks/', arguments: {'userId': formStore.loggedUser?.id});
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
      appBar: AppBar(
        title: const Text('Sign In', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),),
      ),
      body: Container(
        width: 600,
        height: 600,
        padding: const EdgeInsets.all(16.0),
        child: Observer(
          builder: (_) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (formStore.errorMessage.isNotEmpty)
                  Text(
                    formStore.errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Username'),
                  onChanged: formStore.setUsername,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  onChanged: formStore.setPassword,
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: () async {
                    await formStore.doLogin();
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 0, 71, 129), side: const BorderSide(
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
      ),
    );
  }
}
