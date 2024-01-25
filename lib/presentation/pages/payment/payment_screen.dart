import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmock/presentation/pages/payment/add_payment.dart';
import 'package:readmock/presentation/pages/payment/cubit/payment_cubit.dart';
import 'package:readmock/presentation/widgets/custom_scaffold.dart';

import '../../../constant/enum.dart';

class PaymentScreen extends StatelessWidget {
  PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    List<Map<String, dynamic>> payments = [
      // Sample data for payments, add your actual payment data here
      {
        'amount': '\$1000',
        'date': 'April 5, 2023',
        'status': 'Completed',
        'method': 'Credit Card'
      },
      {
        'amount': '\$250',
        'date': 'April 3, 2023',
        'status': 'Pending',
        'method': 'Bank Transfer'
      },
      // Add more payment records as needed
    ];

    return CustomScaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => AddPaymentScreen()));
        },
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<PaymentCubit>().getPayments();
        },
        child: BlocBuilder<PaymentCubit, PaymentState>(
          builder: (context, state) {
            if (state.getPaymentStatus == StateStatusEnum.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state.getPaymentStatus == StateStatusEnum.error) {
              return Center(
                child: Text(state.getPaymentError),
              );
            }

            if (state.getPaymentStatus == StateStatusEnum.success) {
              return ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 5),
                itemCount: state.payments.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.payments[index].dealerName!,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Rs. ' + state.payments[index].amount!,
                            style: theme.textTheme.headline6,
                          ),
                          const SizedBox(height: 4),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.payments[index].depositDate.toString(),
                          ),
                          Text(state.payments[index].modeOfPayment.toString()),
                        ],
                      ),
                      trailing: Text(
                        state.payments[index].status!,
                        style: TextStyle(
                          color: state.payments[index].status == 'approved'
                              ? Colors.green
                              : Colors.amber,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
