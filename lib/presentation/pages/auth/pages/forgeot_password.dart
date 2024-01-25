import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_field.dart';
import '../../../../core/di/locator.dart';
import '../../../../core/utils/dialog_utils.dart';

import '../../../../constant/enum.dart';
import '../blocs/forgot_password/forgot_password_cubit.dart';
import 'otp.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final OtpFieldController otpController = OtpFieldController();

  final GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(getInstance()),
      child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
          listener: (context, state) {
        // if (state.emailStatus == StateStatusEnum.loading) {
        //   DialogUtils.buildLoadingDialog(context);
        // }
        print('email ' + state.emailStatus.toString());
        print('otp ${state.otpStatus}');
        print('password ${state.passwordStatus}');

        if (state.emailStatus == StateStatusEnum.loading) {
          DialogUtils.buildLoadingDialog(context);
        }

        if (state.emailStatus == StateStatusEnum.error) {
          Navigator.of(context).pop();
          Navigator.pop(context);

          DialogUtils.buildErrorMessageDialog(context,
              message: state.emailError, title: 'Error', onClose: () {
            Navigator.of(context).pop();
          });
        }

        if (state.emailStatus == StateStatusEnum.success) {
          Navigator.pop(context);
          Navigator.pop(context);
        }

        if (state.otpStatus == StateStatusEnum.loading) {
          DialogUtils.buildLoadingDialog(context);
        }
        if (state.otpStatus == StateStatusEnum.error) {
          Navigator.pop(context);
          DialogUtils.buildErrorMessageDialog(context,
              message: state.otpError, title: 'Error', onClose: () {
            Navigator.pop(context);
          });
        }

        if (state.otpStatus == StateStatusEnum.success) {
          Navigator.pop(context);
          Navigator.of(context).pop();
        }

        if (state.passwordStatus == StateStatusEnum.loading) {
          DialogUtils.buildLoadingDialog(context);
        }
        if (state.passwordStatus == StateStatusEnum.error) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();

          DialogUtils.buildErrorMessageDialog(context,
              message: state.passwordError, title: 'Error', onClose: () {
            Navigator.pop(context);
          });
        }

        if (state.passwordStatus == StateStatusEnum.success) {
          Navigator.pop(context);
          Navigator.of(context).pop();
        } else {}
      }, builder: (context, state) {
        return Scaffold(
            body: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.arrow_back))),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    3,
                    (index) => Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: 60,
                        height: 4,
                        decoration: BoxDecoration(
                          color: state.currentIndex >= index
                              ? Colors.indigo
                              : Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 600,
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller:
                      context.read<ForgotPasswordCubit>().pageController,
                  onPageChanged: ((value) {}),
                  children: [
                    forgotRequest(context),
                    validateCode(context),
                    resetPassword(context)
                  ],
                ),
              )
            ],
          ),
        ));
      }),
    );
  }

  Widget forgotRequest(BuildContext context) {
    return Form(
      // key: controller.forgetRequestformKey,
      key: emailFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 60,
            ),
            const Text(
              'Forgot Password',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Enter your email address to reset your password',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              focusNode:
                  BlocProvider.of<ForgotPasswordCubit>(context).emailFocusNode,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller:
                  BlocProvider.of<ForgotPasswordCubit>(context).emailController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Email is required';
                }
                if (!value.contains('@')) {
                  return 'Email is invalid';
                }
                return null;
              },
              decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (emailFormKey.currentState!.validate()) {
                    BlocProvider.of<ForgotPasswordCubit>(context)
                        .checkIfEmailIsValid();
                  }
                },
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget validateCode(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 60,
          ),
          const Text(
            'Check Email For OTP',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'To reset your password, please enter the 6-digit code sent to your email address.',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const SizedBox(
            height: 20,
          ),
          OtpVerify(
              numberOfFields: 6,
              textStyle: TextStyle(fontSize: 20, color: Colors.black),
              onOtpEntered: (value) {
                context.read<ForgotPasswordCubit>().otpController.text = value;
              }),

          //Submit button

          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // if (controller.otpEditingController.text.length == 6) {
                //   controller.isLoading(true);
                //   controller.validateOtp();
                // }

                context.read<ForgotPasswordCubit>().checkIfOtpIsValid();
              },
              child: const Text('Continue'),
            ),
          ),
        ],
      ),
    );
  }

  Widget resetPassword(BuildContext context) {
    return Form(
      key: passwordFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Reset Password',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 10,
            ),
            const Text(
                'Enter your new password, password must be 8 characters and different from previous used password'),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: BlocProvider.of<ForgotPasswordCubit>(context)
                  .passwordController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Password is required';
                }
                if (value.length < 8) {
                  return 'Password must be 8 characters';
                }
                return null;
              },
              decoration: const InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: BlocProvider.of<ForgotPasswordCubit>(context)
                  .confirmPasswordController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Confirm Password is required';
                }
                if (value !=
                    BlocProvider.of<ForgotPasswordCubit>(context)
                        .passwordController
                        .text) {
                  return 'Password does not match';
                }
                return null;
              },
              decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (passwordFormKey.currentState!.validate()) {
                    BlocProvider.of<ForgotPasswordCubit>(context)
                        .resetPassword();
                  }
                },
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
