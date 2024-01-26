import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmock/config/app_text_styles.dart';
import 'package:readmock/domain/model/trip.dart';
import 'package:readmock/presentation/pages/assigned/cubit/assigned_cubit.dart';
import 'package:readmock/presentation/pages/assigned/trip_start_screen.dart';
import 'package:readmock/presentation/widgets/custom_scaffold.dart';
import 'package:readmock/presentation/widgets/horizontal_line.dart';

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
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => TripStartScreen(
                                      trip: trip,
                                    )));
                      },
                      child: Card(
                        elevation: 4.0,
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 6.0),
                        child: Container(
                            decoration: BoxDecoration(),
                            child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                title: Row(
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: Colors.blueGrey,
                                        child: Icon(Icons.person_pin_outlined)),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          trip.trip!.user!.name!,
                                          style:
                                              AppTextStyle.h4TitleTextStyle(),
                                        ),
                                        Text(
                                          "Rs. " +
                                              trip.trip!.totalPrice.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        )
                                      ],
                                    ),
                                    Spacer(),
                                    Text(
                                      trip.tripStatus == null
                                          ? 'Not Started'
                                          : trip.tripStatus == 1
                                              ? 'Completed'
                                              : 'Started',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(
                                              color: trip.tripStatus == 0 ||
                                                      trip.tripStatus == 1
                                                  ? Colors.green
                                                  : Colors.grey),
                                    )
                                  ],
                                ),
                                // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Divider(),
                                    Text(trip.trip!.from!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith()),
                                    Icon(Icons.more_vert_sharp,
                                        color: Colors.green),
                                    Text(trip.trip!.to.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith())
                                  ],
                                ),
                                isThreeLine: true)),
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
