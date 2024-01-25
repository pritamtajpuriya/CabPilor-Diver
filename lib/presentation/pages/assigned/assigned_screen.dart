import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmock/domain/model/trip.dart';
import 'package:readmock/presentation/pages/assigned/cubit/assigned_cubit.dart';
import 'package:readmock/presentation/widgets/custom_scaffold.dart';

import '../../../constant/enum.dart';
import '../../widgets/not_found.dart';

class AssignedScreen extends StatefulWidget {
  const AssignedScreen({super.key});

  @override
  State<AssignedScreen> createState() => _AssignedScreenState();
}

class _AssignedScreenState extends State<AssignedScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AssignedCubit>().getTripsList();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<AssignedCubit>().getTripsList();
        },
        child: BlocBuilder<AssignedCubit, AssignedState>(
          builder: (context, state) {
            if (state.getAssignedStatus == StateStatusEnum.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state.getAssignedStatus == StateStatusEnum.error) {
              return Center(
                  child: Text(
                state.getAssignedError,
              ));
            }
            if (state.getAssignedStatus == StateStatusEnum.success) {
              if (state.assignedList.isEmpty) {
                return NotFound(
                  titile: 'No Trips Found',
                );
              }
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.assignedList.length,
                  itemBuilder: (context, index) {
                    Trip trip = state.assignedList[index];
                    return Card(
                      elevation: 4.0,
                      margin:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(64, 75, 96, .9)),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          leading: Container(
                            padding: EdgeInsets.only(right: 12.0),
                            decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                        width: 1.0, color: Colors.white24))),
                            child: Icon(Icons.autorenew, color: Colors.white),
                          ),
                          title: Text(
                            trip.trip!.user!.name!,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                          subtitle: Row(
                            children: <Widget>[
                              Icon(Icons.linear_scale,
                                  color: Colors.yellowAccent),
                              Text(trip.trip!.id.toString(),
                                  style: TextStyle(color: Colors.white))
                            ],
                          ),
                          trailing: Icon(Icons.keyboard_arrow_right,
                              color: Colors.white, size: 30.0),
                          onTap: () {
                            // Logic to open Trip details
                          },
                        ),
                      ),
                    );
                  });
            }
            return Container();
          },
        ),
      ),
    );
  }
}
