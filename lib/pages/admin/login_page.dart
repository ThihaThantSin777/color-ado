import 'package:color_ado/bloc/admin/login_bloc.dart';
import 'package:color_ado/pages/admin/admin_home_page.dart';
import 'package:color_ado/utils/image_utils.dart';
import 'package:color_ado/widgets/loadin_dialog_widget.dart';
import 'package:color_ado/widgets/sample_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginBloc>(
      create: (_) => LoginBloc(),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Image.asset(
                      ImageUtils.kAppLogo,
                      width: 200,
                      height: 200,
                    ),
                    const Text(
                      'Technology University Colorado',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Builder(builder: (context) {
                      return MaterialButton(
                        minWidth: double.infinity,
                        color: Colors.blue,
                        textColor: Colors.white,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final bloc = context.read<LoginBloc>();
                            String email = _emailController.text;
                            String password = _passwordController.text;
                            showDialog(context: context, builder: (_) => const LoadingDialog());
                            bloc.onTapLogin(email, password).then((value) {
                              Navigator.of(context).pop();
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (_) => AdminHomePage(
                                          userEmail: email,
                                        )),
                                (route) => false,
                              );
                            }).catchError((error) {
                              Navigator.of(context).pop();
                              showDialog(
                                  context: context,
                                  builder: (_) => SampleDialogWidget(
                                        title: 'Error',
                                        content: error.toString(),
                                        buttonText: 'OK',
                                        onButtonPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ));
                            });
                          }
                        },
                        child: const Text('Login'),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
