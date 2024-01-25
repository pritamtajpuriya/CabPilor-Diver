import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:readmock/presentation/pages/payment/cubit/payment_cubit.dart';
import 'package:readmock/presentation/widgets/custom_date_picker.dart';
import 'package:readmock/presentation/widgets/custom_dropdown.dart';
import 'package:readmock/presentation/widgets/custom_scaffold.dart';
import 'package:readmock/presentation/widgets/custom_text_field.dart';
import 'package:readmock/presentation/widgets/custome_button.dart';

import '../../../constant/enum.dart';
import '../../../core/utils/dialog_utils.dart';
import '../../../data/request/payment_request.dart';

class AddPaymentScreen extends StatelessWidget {
  AddPaymentScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  var modeOfPayment = '';

  //amount

  TextEditingController amountCtr = TextEditingController();

  TextEditingController dealerNameCtr = TextEditingController();
  TextEditingController chequeNameCtr = TextEditingController();
  //chequeBank
  TextEditingController chequeBankCtr = TextEditingController();
  // chequeNo
  TextEditingController chequeNoCtr = TextEditingController();
  // chequeDate
  TextEditingController chequeDateCtr = TextEditingController();
  // depositor
  TextEditingController depositorCtr = TextEditingController();

  // deposite Date
  TextEditingController depositeDateCtr = TextEditingController();

  //Depositor Bank
  TextEditingController depositorBankCtr = TextEditingController();

  //receivedBank
  TextEditingController receivedBankCtr = TextEditingController();
  //remark
  TextEditingController remarkCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: Text('Add Payment'),
      ),
      body: BlocListener<PaymentCubit, PaymentState>(
        listener: (context, state) {
          if (state.createPaymentStatus == StateStatusEnum.success) {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Fluttertoast.showToast(
              msg: 'Payment Added Successfully',
            );
          }
          if (state.createPaymentStatus == StateStatusEnum.error) {
            Navigator.of(context).pop();
            DialogUtils.buildErrorMessageDialog(context,
                message: state.createPaymentError, onClose: () {
              Navigator.of(context).pop();
            });
          }
          if (state.createPaymentStatus == StateStatusEnum.loading) {
            DialogUtils.buildLoadingDialog(context);
          }
        },
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 16,
                ),
                //amount
                CustomTextField(
                  label: 'Amount',
                  controller: amountCtr,
                  hintText: 'Enter Amount',
                  keyboardType: TextInputType.number,
                ),

                // Padding(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                //   child: CustomDropdown(
                //     options: ['Cash', 'Cheque', 'FonePay'],
                //     onOptionSelected: (value) {
                //       modeOfPayment = value;
                //     },
                //     title: 'Mode Of Payment',
                //   ),
                // ),

                //dealerName
                CustomTextField(
                  label: 'Dealer Name',
                  controller: dealerNameCtr,
                  hintText: 'Enter Dealer Name',
                ),
                SizedBox(
                  height: 6,
                ),

                //chequeName
                CustomTextField(
                  label: 'Cheque Name',
                  controller: chequeNameCtr,
                  hintText: 'Enter Cheque Name',
                ),
                SizedBox(
                  height: 6,
                ),

                //chequeBank
                CustomTextField(
                  label: 'Cheque Bank',
                  controller: chequeBankCtr,
                  hintText: 'Enter Cheque Bank',
                ),
                SizedBox(
                  height: 6,
                ),

                //chequeNo

                CustomTextField(
                  label: 'Cheque No',
                  controller: chequeNoCtr,
                  hintText: 'Enter Cheque No',
                ),
                SizedBox(
                  height: 6,
                ),

                //chequeDate

                //depositeDate
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomeDatePicker(
                      dobController: chequeDateCtr,
                      title: 'Cheque Date',
                      selectedDate: DateTime.now(),
                      onDateChanged: (value) {
                        log(value.toString());
                        chequeDateCtr.text = value.toString().split(' ')[0];
                      }),
                ),
                SizedBox(
                  height: 6,
                ),

                //depositor

                CustomTextField(
                  label: 'Depositor',
                  controller: depositorCtr,
                  hintText: 'Enter Depositor',
                ),
                SizedBox(
                  height: 6,
                ),

                //depositeDate
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomeDatePicker(
                      dobController: depositeDateCtr,
                      title: 'Deposite Date',
                      selectedDate: DateTime.now(),
                      onDateChanged: (value) {
                        log(value.toString());
                        depositeDateCtr.text = value.toString().split(' ')[0];
                      }),
                ),
                SizedBox(
                  height: 6,
                ),

                //Depositor Bank

                CustomTextField(
                  label: 'Depositor Bank',
                  controller: depositorBankCtr,
                  hintText: 'Enter Depositor Bank',
                ),
                SizedBox(
                  height: 6,
                ),

                //receivedBank

                CustomTextField(
                  label: 'Received Bank',
                  controller: receivedBankCtr,
                  hintText: 'Enter Received Bank',
                ),
                SizedBox(
                  height: 6,
                ),

                //remark

                CustomTextField(
                  label: 'Remark',
                  controller: remarkCtr,
                  hintText: 'Enter Remark',
                ),

                const SizedBox(
                  height: 10,
                ),

                CustomButton(
                    label: 'Save',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context
                            .read<PaymentCubit>()
                            .createPayment(PaymentRequest(
                              modeOfPayment: modeOfPayment,
                              dealerName: dealerNameCtr.text,
                              chequeBank: chequeBankCtr.text,
                              chequeNo: chequeNoCtr.text,
                              chequeDate: chequeDateCtr.text,
                              depositor: depositorCtr.text,
                              depositDate: depositeDateCtr.text,
                              depositBankName: depositorBankCtr.text,
                              recivedBank: receivedBankCtr.text,
                              remark: remarkCtr.text,
                              saleofficerId: '',
                              amount: amountCtr.text,
                            ));
                      }
                    }),

                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
