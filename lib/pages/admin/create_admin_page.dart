import 'package:color_ado/bloc/admin/create_admin_bloc.dart';
import 'package:color_ado/pages/admin/admin_home_page.dart';
import 'package:color_ado/utils/image_utils.dart';
import 'package:color_ado/widgets/loadin_dialog_widget.dart';
import 'package:color_ado/widgets/sample_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateAdminPage extends StatefulWidget {
  const CreateAdminPage({super.key});

  @override
  State<CreateAdminPage> createState() => _CreateAdminPageState();
}

class _CreateAdminPageState extends State<CreateAdminPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CreateAdminBloc>(
      create: (_) => CreateAdminBloc(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                      controller: _usernameController,
                      decoration: const InputDecoration(labelText: 'Username'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
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
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _confirmPasswordController,
                      decoration: const InputDecoration(labelText: 'Confirm Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        } else if (value != _passwordController.text) {
                          return 'Passwords do not match';
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
                            final bloc = context.read<CreateAdminBloc>();
                            String userName = _usernameController.text;
                            String email = _emailController.text;
                            String password = _passwordController.text;
                            showDialog(context: context, builder: (_) => const LoadingDialog());
                            bloc.onTapRegister(userName, email, password).then((value) {
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
                        child: const Text('Register'),
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
