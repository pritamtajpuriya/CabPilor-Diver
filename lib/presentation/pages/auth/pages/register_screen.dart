import 'package:flutter/material.dart';
import 'package:readmock/presentation/widgets/custome_button.dart';
import '../../../../config/routes_manager.dart';
import '../../../../core/utils/dialog_utils.dart';
import '../blocs/register/register_bloc.dart';

import '../../../../config/size_config.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../../common_bloc/auth/auth_bloc.dart';
import '../../../widgets/custom_scaffold.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  //Global key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            Navigator.of(context, rootNavigator: true).pop();

            context.read<AuthBloc>().add(AuthCheck());
          }
          if (state is RegisterFailure) {
            Navigator.of(context).pop();
            DialogUtils.buildErrorMessageDialog(context,
                message: state.message,
                title: 'Registration Failed', onClose: () {
              Navigator.of(context).pop();
            });
          }
          if (state is RegisterLoading) {
            DialogUtils.buildLoadingDialog(context);
          }
        },
        child: CustomScaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                // _buildTopeSection(context),
                _registerPart(context),
              ],
            ),
          ),
        ));
  }

  Widget _registerPart(BuildContext context) {
    return Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
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
                    controller:
                        context.watch<RegisterBloc>().fullNameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your full name';
                      }

                      List<String> nameParts = value.trim().split(' ');
                      if (nameParts.length < 2) {
                        return 'Please enter your last name';
                      }

                      // You can add more specific validation rules here if needed

                      return null; // Return null to indicate no validation errors
                    },
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                        labelText: 'Full Name',
                        prefixIcon: Icon(Icons.person),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14)),
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email is required';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    controller: context.watch<RegisterBloc>().emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14)),
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller:
                        context.watch<RegisterBloc>().passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password cannot be empty';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller:
                        context.watch<RegisterBloc>().confirmPasswordController,
                    validator: (value) {
                      // must match
                      if (value !=
                          context
                              .read<RegisterBloc>()
                              .passwordController
                              .text) {
                        return 'Password must match';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: '',
                        prefixIcon: Icon(Icons.lock),
                        labelText: 'Confirm Password',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14)),
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  CustomButton(label: 'Register', onPressed: () {}),
                  const SizedBox(
                    height: 30,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?  ',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AppRouter.login);
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.indigo,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }

  Widget _buildTopeSection(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.indigo),
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),

                const Text('Have an account?',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text('Sign In',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                )

                // logo with cotainer and white text Readmock
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            'ReadMock ',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
