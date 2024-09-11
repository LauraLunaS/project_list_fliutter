import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:project_list_fliutter/src/modules/auth/presenter/stores/sign_up_store.dart';
import 'package:window_manager/window_manager.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with WindowListener {
  late final SignUpStore signUpStore;

  @override
  void initState() {
    super.initState();
    signUpStore = context.read<SignUpStore>();
    reaction((react) => signUpStore.isLoading, (action) => Modular.to.navigate('/sign_in'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Observer(
          builder: (_) {
            return Column(
              children: [
                if (signUpStore.errorMessage.isNotEmpty)
                  Text(
                    signUpStore.errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Username'),
                  onChanged: signUpStore.setUsername,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  onChanged: signUpStore.setPassword,
                ),
                TextField(
                  decoration:
                      const InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
                  onChanged: signUpStore.setConfirmPassword,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: signUpStore.isLoading
                      ? null
                      : () async {
                          await signUpStore.register(
                            signUpStore.username,
                            signUpStore.password,
                            signUpStore.confirmPassword,
                          );
                        },
                  child: signUpStore.isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Sign Up'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
