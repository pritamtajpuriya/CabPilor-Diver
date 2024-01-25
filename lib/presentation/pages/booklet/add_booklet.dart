import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:readmock/constant/enum.dart';
import 'package:readmock/core/di/locator.dart';
import 'package:readmock/core/utils/dialog_utils.dart';
import 'package:readmock/data/request/create_booklet_request.dart';
import 'package:readmock/presentation/pages/booklet/cubit/booklet_cubit.dart';
import 'package:readmock/presentation/pages/customer/bloc/customer_cubit.dart';
import 'package:readmock/presentation/widgets/custom_dropdown.dart';
import 'package:readmock/presentation/widgets/custom_text_field.dart';
import 'package:readmock/presentation/widgets/custome_button.dart';

class AddBookletPage extends StatefulWidget {
  AddBookletPage({Key? key}) : super(key: key);

  @override
  _AddBookletPageState createState() => _AddBookletPageState();
}

class _AddBookletPageState extends State<AddBookletPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _partyNameController = TextEditingController();
  final TextEditingController _saleOfficerController = TextEditingController();
  final TextEditingController _bookletNumberController =
      TextEditingController();
  final TextEditingController _billingRateCtr = TextEditingController();
  final TextEditingController _orderDateController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _offerValidityController =
      TextEditingController();
  final TextEditingController _deliveryAddressController =
      TextEditingController();

  int? customerId;
  var vehicleType = '';
  var paymentMode = '';

  //Remark
  final TextEditingController _remarkController = TextEditingController();

  @override
  void dispose() {
    _partyNameController.dispose();
    _saleOfficerController.dispose();
    _bookletNumberController.dispose();
    _billingRateCtr.dispose();
    _orderDateController.dispose();
    _quantityController.dispose();
    _offerValidityController.dispose();
    _deliveryAddressController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Here you can handle the data submission, for example sending data to API or adding to a list
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Booklet'),
      ),
      body: BlocListener<BookletCubit, BookletState>(
        listener: (context, state) {
          if (state.createBookletStatus == StateStatusEnum.success) {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Fluttertoast.showToast(
              msg: 'Booklet Added Successfully',
            );
          }

          if (state.createBookletStatus == StateStatusEnum.error) {
            Navigator.of(context).pop();
            DialogUtils.buildErrorMessageDialog(context,
                message: state.createBookletError, onClose: () {
              Navigator.of(context).pop();
            });
          }

          if (state.createBookletStatus == StateStatusEnum.loading) {
            DialogUtils.buildLoadingDialog(context);
          }
        },
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            children: [
              CustomTextField(
                label: 'Billing Rate',
                hintText: 'Enter Billing Rate',
                controller: _billingRateCtr,
                keyboardType: TextInputType.number,
              ),

              SizedBox(
                height: 10,
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: DropdownButtonFormField<int>(
                    hint: Text('Select Customer'),
                    items: context
                        .read<CustomerCubit>()
                        .state
                        .customers
                        .map((customer) {
                      return DropdownMenuItem(
                        value: customer.id!,
                        child: Text(customer.name!),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                    ),
                    onChanged: (value) {
                      setState(() {
                        customerId = value;
                      });
                    }),
              ),

              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              //   child: CustomDropdown(
              //       validator: (value) {
              //         if (value == null) {
              //           return 'Please select a vehicle type';
              //         }
              //         return null;
              //       },
              //       options: ['Party'],
              //       onOptionSelected: (title) {
              //         setState(() {
              //           vehicleType = title;
              //         });
              //       },
              //       title: 'Vehicle'),
              // ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: DropdownButtonFormField<String>(
                    hint: Text('Select Payment Mode'),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a vehicle type';
                      }
                      return null;
                    },
                    items: [
                      DropdownMenuItem(
                          value: 'cashinadvance',
                          child: Text('Cash In Advance')),
                      ...context
                          .read<BookletCubit>()
                          .state
                          .paymentTerms
                          .where((element) =>
                              !element.label!.toLowerCase().contains('cash'))
                          .map((e) => DropdownMenuItem(
                              value: 'BG-${e.id}',
                              child: Text('BG ' + e.label!)))
                          .toList(),
                      ...context
                          .read<BookletCubit>()
                          .state
                          .paymentTerms
                          .where((element) =>
                              !element.label!.toLowerCase().contains('cash'))
                          .map((e) => DropdownMenuItem(
                              value: 'LC-${e.id}',
                              child: Text('LC ' + e.label!)))
                          .toList(),

                      //PDC
                      ...context
                          .read<BookletCubit>()
                          .state
                          .paymentTerms
                          .where((element) =>
                              !element.label!.toLowerCase().contains('cash'))
                          .map((e) => DropdownMenuItem(
                              value: 'PDC-${e.id}',
                              child: Text('PDC ' + e.label!)))
                          .toList()
                    ],
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.payment),
                    ),
                    onChanged: (value) {
                      setState(() {
                        paymentMode = value.toString();
                      });
                    }),
              ),

              //party name
              // User search text field

              SizedBox(
                height: 10,
              ),
              //quantity
              CustomTextField(
                  label: 'Quantity',
                  hintText: 'Enter Quantity',
                  keyboardType: TextInputType.number,
                  controller: _quantityController),

              SizedBox(
                height: 10,
              ),

              //delivery address
              CustomTextField(
                  label: 'Delivery Address',
                  hintText: 'Enter Delivery Address',
                  keyboardType: TextInputType.streetAddress,
                  controller: _deliveryAddressController),

              SizedBox(
                height: 20,
              ),

              //Remark
              CustomTextField(
                label: 'Remark',
                controller: _remarkController,
                hintText: 'Enter Remarks',
              ),

              SizedBox(
                height: 20,
              ),

              CustomButton(
                  label: 'Save',
                  onPressed: () {
                    log('Create Booklet');
                    if (_formKey.currentState!.validate()) {
                      context
                          .read<BookletCubit>()
                          .createBooklet(CreateBookletRequest(
                            billingRate: int.parse(_billingRateCtr.text),
                            quantity: int.parse(_quantityController.text),
                            deliveryAddress: _deliveryAddressController.text,
                            vehicle: vehicleType,
                            remarks: _remarkController.text,
                            paymentTermType: paymentMode
                                .replaceAll(' ', '-')
                                .replaceAll('days', ''),
                            userId: customerId.toString(),
                          ));
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
