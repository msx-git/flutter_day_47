import 'package:flutter/material.dart';
import 'package:flutter_day_47/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../../controllers/auth_controller.dart';
import '../../utils/app_routes.dart';
import '../../utils/show_loader.dart';
import '../widgets/app_textformfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  submit() async {
    if (formKey.currentState!.validate()) {
      Messages.showLoadingDialog(context);
      await context.read<AuthController>().login(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
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
                    return "Enter password address!";
                  }
                  return null;
                },
              ),
              12.height,
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: submit,
                  child: const Text("Sign in"),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.register);
                },
                child: const Text("Register"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
