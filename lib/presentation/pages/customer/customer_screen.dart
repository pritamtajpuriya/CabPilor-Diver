import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmock/core/di/locator.dart';
import 'package:readmock/presentation/pages/customer/add_customer_screen.dart';
import 'package:readmock/presentation/pages/customer/bloc/customer_cubit.dart';
import 'package:readmock/presentation/widgets/custom_scaffold.dart';

import '../../../constant/enum.dart';

class CustomerScreen extends StatefulWidget {
  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  // Add more customers as needed

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddCustomerScreen()));

          context.read<CustomerCubit>().getCustomers();
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<CustomerCubit>().getCustomers();
        },
        child: Column(
          children: [
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
            BlocBuilder<CustomerCubit, CustomerState>(
                builder: (context, state) {
              if (state.getCustomerStatus == StateStatusEnum.loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state.getCustomerStatus == StateStatusEnum.error) {
                return Center(
                  child: Text(state.getCustomerError),
                );
              }
              if (state.getCustomerStatus == StateStatusEnum.success) {
                return state.customers.isEmpty
                    ? Center(child: Text('No customers found'))
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.customers.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 4,
                            margin: EdgeInsets.all(10),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                child: Text(state.customers[index].name![
                                    0]), // Display first letter of the name
                              ),
                              title: Text(state.customers[index].name!),
                              subtitle: Text(state.customers[index].email!),
                              // Add action buttons if needed
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
    );
  }
}
