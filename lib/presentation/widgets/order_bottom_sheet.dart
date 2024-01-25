import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:readmock/core/resources/assets_manager.dart';
import 'package:readmock/core/utils/dialog_utils.dart';
import 'package:readmock/domain/model/order.dart';
import 'package:readmock/presentation/pages/orders/cubit/order_cubit.dart';

import '../../constant/enum.dart';
import '../../core/utils/dimensions.dart';

class OderBottomSheet extends StatelessWidget {
  String? title;
  String? message;

  BookingOrder? order;

  VoidCallback? onExit;
  OderBottomSheet(
      {Key? key,
      this.title = 'New Order',
      this.message = 'You have a new order. Do you want to accept it?',
      this.onExit,
      this.order})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderCubit, OrderState>(
      listener: (context, state) {
        if (state.acceptOrderStatus == StateStatusEnum.success) {
          Navigator.of(context).pop();
          Fluttertoast.showToast(
              msg: 'Order Accepted', backgroundColor: Colors.red);
          // DialogUtils.buildSuccessMessageDialog(context,
          //     message: 'Order Accepted', onDone: () {
          //   Navigator.of(context).pop();
          // });
        }
        if (state.acceptOrderStatus == StateStatusEnum.error) {
          Fluttertoast.showToast(
              msg: state.acceptOrderError, backgroundColor: Colors.red);

          if (state.acceptOrderError.toLowerCase() == 'trip already assigned') {
            Navigator.of(context).pop();
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 40, top: 15),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.vertical(
                top: Radius.circular(Dimensions.paddingSizeDefault))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                  color: Theme.of(context).hintColor.withOpacity(.5),
                  borderRadius: BorderRadius.circular(20)),
            ),
            const SizedBox(
              height: 30,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(
            //       vertical: Dimensions.paddingSizeDefault),
            //   child: SizedBox(width: 60, child: Image.asset(ImageAssets.logo)),
            // ),
            const SizedBox(
              height: Dimensions.paddingSizeExtraSmall,
            ),
            Text(
              title!,
              style: Theme.of(context).textTheme.titleMedium,
            ),

            SizedBox(
              height: 20,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(
            //       top: Dimensions.paddingSizeSmall,
            //       bottom: Dimensions.paddingSizeLarge),
            //   child: Text(message!,
            //       textAlign: TextAlign.center,
            //       style: Theme.of(context).textTheme.titleSmall),
            // ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pickup Distance: ${order!.distance}',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(
                    height: 4,
                  ),

                  //Total price
                  Text('Total Price: ${order!.totalPrice}',
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(
                    height: 4,
                  ),

                  //from
                  Text('From: ${order!.from}',
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(
                    height: 4,
                  ),

                  //to
                  Text('To: ${order!.to}',
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(
                    height: 4,
                  ),

                  //trans_type
                  Text(
                    'Trans Type: ${order!.transType}',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(
                    height: 4,
                  ),

                  //Customer name
                  Text('Customer Name: ${order!.user!.name}',
                      style: Theme.of(context).textTheme.titleSmall),
                ],
              ),
            ),

            const SizedBox(height: Dimensions.paddingSizeDefault),

            context.watch<OrderCubit>().state.acceptOrderStatus ==
                    StateStatusEnum.loading
                ? const CircularProgressIndicator()
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeOverLarge),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //  cancel button
                        // withour custome
                        Expanded(
                          child: ElevatedButton(
                              style:
                                  ElevatedButton.styleFrom(primary: Colors.red),
                              onPressed: () {
                                log(context
                                    .read<OrderCubit>()
                                    .state
                                    .toString());
                                context.read<OrderCubit>().acceptRejectOrder(0);
                              },
                              child: Text('Reject'.toUpperCase())),
                        ),

                        const SizedBox(
                          width: Dimensions.paddingSizeDefault,
                        ),
                        //  exit button
                        Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green),
                              onPressed: onExit ??
                                  () {
                                    context
                                        .read<OrderCubit>()
                                        .acceptRejectOrder(1);
                                  },
                              child: Text('Accept'.toUpperCase())),
                        ),
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
