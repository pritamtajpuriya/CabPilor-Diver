import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmock/presentation/pages/splash/splash_screen.dart';
import 'package:readmock/presentation/widgets/custome_button.dart';

import '../../../../config/routes_manager.dart';
import '../../../../config/size_config.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/utils/dialog_utils.dart';
import '../../../common_bloc/auth/auth_bloc.dart';
import '../../../widgets/custom_scaffold.dart';
import '../blocs/login/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            DialogUtils.buildLoadingDialog(context);
          }
          if (state is LoginSuccess) {
            Navigator.of(context, rootNavigator: true).pop();

            context.read<AuthBloc>().add(AuthCheck());
          }

          if (state is LoginFailure) {
            Navigator.of(context).pop();
            // DialogUtils.buildErrorMessageDialog(
            //   context,
            //   message: state.message,
            //   onClose: () {
            //     Navigator.of(context, rootNavigator: true).pop();
            //   },
            // );
            CoolAlert.show(
              context: context,
              type: CoolAlertType.error,
              title: 'Login Failed',
              text: state.message,
              confirmBtnColor: Colors.indigo,
              onConfirmBtnTap: () {},
            );
          }
        },
        child: CustomScaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                // _buildTopSection(context),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                _loginPart(context),
              ],
            ),
          ),
        ));
  }

  Widget _loginPart(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Welcome Back',
                      style: getBoldStyle(color: Colors.black, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Enther your details below
                    const Text(
                      'Enter your details below',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),

                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: context.watch<LoginBloc>().emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email is required';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          hintText: 'Email Address',
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 14)),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: context.watch<LoginBloc>().passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is required';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 8 characters';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          hintText: 'Password',
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 14)),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AppSizeBox.height10,

                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(AppRouter.forgotPassword);
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomButton(
                        label: 'Login',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<LoginBloc>().add(performLoginEvent());
                          }
                        }),
                    const SizedBox(
                      height: 30,
                    ),
                    // const Text(
                    //   'Or Login with',
                    //   style: TextStyle(
                    //       color: Colors.grey,
                    //       fontSize: 14,
                    //       fontWeight: FontWeight.bold),
                    // ),
                    // const SizedBox(
                    //   height: 30,
                    // ),
                    // const SocialLogin(),

                    const SizedBox(
                      height: 30,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account?  ',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(AppRouter.register);
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                                color: Colors.indigo,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ))));
  }

  Widget _buildTopSection(BuildContext context) {
    return Column(
      children: [
        // Welcome back

        //slogan
        // AppName

        Text(
          'Welcome Back',
          style: getBoldStyle(color: Colors.white, fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        // Enther your details below
        const Text(
          'Enter your details below',
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        const SizedBox(
          height: 30,
        ),

        Text(
          'Rea',
          style: getBoldStyle(color: Colors.white, fontSize: 20),
        ),
      ],
    );
  }
}
