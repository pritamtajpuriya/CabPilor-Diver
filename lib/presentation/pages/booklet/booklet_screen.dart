import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmock/presentation/pages/booklet/add_booklet.dart';
import 'package:readmock/presentation/pages/booklet/cubit/booklet_cubit.dart';
import 'package:readmock/presentation/widgets/custom_scaffold.dart';

import '../../../constant/enum.dart';

class BookletScreen extends StatelessWidget {
  BookletScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> booklets = [
    {
      'status': 'Pending',
      'partyName': 'Riverport Steel',
      'saleOfficer': 'Sashank shrestha',
      'bookletNumber': '4787',
      'todaysRate': '31',
      'orderDate': '2024-01-08',
      'quantity': '10.00',
      'offerValidity': '2024-01-11',
      'deliveryAddress': 'Hello',
    },

    {
      'status': 'Pending',
      'partyName': 'WatermelonPatry',
      'saleOfficer': 'Sashank shrestha',
      'bookletNumber': '4787',
      'todaysRate': '31',
      'orderDate': '2024-01-08',
      'quantity': '10.00',
      'offerValidity': '2024-01-11',
      'deliveryAddress': 'Hello',
    },
    {
      'status': 'Pending',
      'partyName': 'SteelState Industries',
      'saleOfficer': 'Sashank shrestha',
      'bookletNumber': '4787',
      'todaysRate': '31',
      'orderDate': '2024-01-08',
      'quantity': '10.00',
      'offerValidity': '2024-01-11',
      'deliveryAddress': 'Hello',
    },

    // Add more booklet records as needed
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            await Navigator.push(
                context, MaterialPageRoute(builder: (_) => AddBookletPage()));

            context.read<BookletCubit>().getBooklets();
          }),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<BookletCubit>().getBooklets();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              //
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        onChanged: (value) {
                          // Perform the search operation
                        },
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          labelText: 'Search',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 15.0),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Open filter dialog or navigate to filter page
                    },
                    icon: const Icon(Icons.filter_list),
                    label: const Text('Filter'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                    ),
                  ),
                ],
              ),

              BlocBuilder<BookletCubit, BookletState>(
                  builder: (context, state) {
                if (state.getBookletStatus == StateStatusEnum.loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state.getBookletStatus == StateStatusEnum.error) {
                  return Center(
                    child: Text(state.getBookletError),
                  );
                }

                if (state.getBookletStatus == StateStatusEnum.success) {
                  return state.booklets.isEmpty
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          child: Center(child: Text('No Booklets found')))
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.booklets.length,
                          itemBuilder: (context, index) {
                            final booklet = state.booklets[index];
                            return Card(
                              elevation: 4,
                              margin: const EdgeInsets.all(4),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${booklet.user?.name ?? ''}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Booklet Number: ${booklet.bookletNumber ?? ''}',
                                    ),
                                    SizedBox(height: 8),
                                    Text('Status: ${booklet.status ?? ''}'),
                                    SizedBox(height: 4),
                                    Text(
                                        'Billing Rate: ${booklet.billingRate}'),
                                    SizedBox(height: 4),
                                    Text('Order Date: ${booklet.createdAt}'),
                                    SizedBox(height: 4),
                                    Text('Quantity: ${booklet.quantity ?? ''}'),
                                    SizedBox(height: 4),

                                    //payment term
                                    Text(
                                      'Payment Term: ${booklet.paymentTermType ?? ''}',
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                        'Delivery Address: ${booklet.deliveryAddress ?? ''}'),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                }

                return Container();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
