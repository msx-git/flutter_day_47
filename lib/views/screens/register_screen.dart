import 'package:flutter/material.dart';
import 'package:flutter_day_47/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../../controllers/auth_controller.dart';
import '../widgets/app_textformfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  submit() async {
    if (formKey.currentState!.validate()) {
      await context
          .read<AuthController>()
          .register(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          )
          .then(
        (_) {
          emailController.clear();
          passwordController.clear();
          passwordConfirmController.clear();
          Navigator.pop(context);
        },
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTextFormField(
                label: "Email",
                controller: emailController,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Enter email address!";
                  }
                  return null;
                },
              ),
              12.height,
              AppTextFormField(
                label: "Password",
                controller: passwordController,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Enter password!";
                  }
                  return null;
                },
              ),
              12.height,
              AppTextFormField(
                label: "Confirm Password",
                controller: passwordConfirmController,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Enter confirm password!";
                  }
                  if (passwordController.text !=
                      passwordConfirmController.text) {
                    return "Passwords didn't match!";
                  }
                  return null;
                },
              ),
              12.height,
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: submit,
                  child: const Text("Register"),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Login"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
