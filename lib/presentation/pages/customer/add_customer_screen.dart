import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:readmock/core/utils/dialog_utils.dart';
import 'package:readmock/presentation/pages/customer/bloc/customer_cubit.dart';
import 'package:readmock/presentation/widgets/custom_scaffold.dart';
import 'package:readmock/presentation/widgets/custom_text_field.dart';

import '../../../constant/enum.dart';
import '../../../data/request/create_customer_request.dart';

class AddCustomerScreen extends StatefulWidget {
  @override
  _AddCustomerScreenState createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();

    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: Text('Add Customer'),
      ),
      body: BlocListener<CustomerCubit, CustomerState>(
        listener: (context, state) {
          if (state.createCustomerStatus == StateStatusEnum.success) {
            Navigator.pop(context);
            Navigator.pop(context);
            Fluttertoast.showToast(
                msg: 'Customer Added Successfully',
                backgroundColor: Colors.green,
                textColor: Colors.white);

            // context.read<CustomerCubit>().getCustomers();
          }
          if (state.createCustomerStatus == StateStatusEnum.error) {
            Navigator.pop(context);
            DialogUtils.buildErrorMessageDialog(context,
                message: state.createCustomerError, onClose: () {
              Navigator.pop(context);
            });
          }
          if (state.createCustomerStatus == StateStatusEnum.loading) {
            Navigator.pop(context);
            DialogUtils.buildLoadingDialog(
              context,
            );
          }
        },
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 16.0),
              CustomTextField(
                label: 'Full Name',
                controller: _fullNameController,
                hintText: 'Enter Full Name',
              ),
              SizedBox(height: 12.0),
              CustomTextField(
                  label: 'Email',
                  controller: _emailController,
                  hintText: 'Enter Email'),
              SizedBox(height: 12.0),
              CustomTextField(
                  label: 'Phone',
                  controller: _phoneController,
                  hintText: 'Enter Phone',
                  keyboardType: TextInputType.phone,
                  validator: (value) {
//Must be 10 digits
                    if (value!.length != 10) {
                      return 'Phone number must be 10 digits';
                    }
                    return null;
                  }),
              SizedBox(height: 12.0),
              CustomTextField(
                  label: 'Address',
                  controller: _addressController,
                  hintText: 'Enter Address'),
              SizedBox(height: 12.0),
              //Dropdown

              CustomTextField(
                label: 'Password',
                controller: _passwordController,
                hintText: 'Enter Password',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12.0),
              CustomTextField(
                label: 'Confirm Password',
                controller: _confirmPasswordController,
                hintText: 'Enter Confirm Password',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Confirm Password is required';
                  }
                  if (value != _passwordController.text) {
                    return 'Password does not match';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      //Show confirm dialog box
                      DialogUtils.buildConfirmationDialog(context,
                          message:
                              'Are you sure you want to add this customer?',
                          onConfirm: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<CustomerCubit>().createCustomer(
                              CreateCustomerRequest(
                                  name: _fullNameController.text,
                                  email: _emailController.text,
                                  phone: _phoneController.text,
                                  password: _passwordController.text,
                                  adress: _addressController.text));
                        }
                      });
                    },
                    child: Text('Add Customer'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
