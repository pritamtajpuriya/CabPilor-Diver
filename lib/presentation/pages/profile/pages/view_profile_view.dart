import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/app_text_styles.dart';
import '../../../../core/resources/values_manager.dart';
import '../profile_bloc/profile_cubit.dart';

class ViewProfileView extends StatelessWidget {
  ViewProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: _buildActions(context)),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _profilePhotoSection(),
              _formSection(context),
            ],
          ),
        ));
  }

  Widget _formSection(BuildContext context) {
    final stateddd = BlocProvider.of<ProfileCubit>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSizeBox.height10,

          Text('Full Name', style: AppTextStyle.h5TitleTextStyle()),
          AppSizeBox.height10,
          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: stateddd.nameController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              ),
              onChanged: (value) {},
            ),
          ),
          AppSizeBox.height20,
          Text('Email', style: AppTextStyle.h5TitleTextStyle()),
          AppSizeBox.height10,
          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: stateddd.emailController,
              enabled: false,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              ),
            ),
          ),
          AppSizeBox.height20,
          Text('Phone Number', style: AppTextStyle.h5TitleTextStyle()),
          AppSizeBox.height10,
          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              ),
              onChanged: (value) {},
            ),
          ),
          AppSizeBox.height20,
          Text('Address', style: AppTextStyle.h5TitleTextStyle()),
          AppSizeBox.height10,
          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              ),
              onChanged: (value) {},
            ),
          ),
          AppSizeBox.height20,
          Text('Date of Birth', style: AppTextStyle.h5TitleTextStyle()),
          AppSizeBox.height10,

          // Date picker controller

          InkWell(
            onTap: () async {
              // show date picker

              final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now());
            },
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                enabled: false,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                ),
                onChanged: (value) {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _profilePhotoSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300, shape: BoxShape.circle),
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: CircleAvatar(
                      child: Icon(Icons.person),
                      // backgroundImage: NetworkImage(
                      //   'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'
                    ),
                  ),
                ),

                // Image.asset(
                //   'assets/icons/profile.png',
                //   width: MediaQuery.of(context).size.width * 0.2,
                // ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            AppSizeBox.height20,

            Text(
              'Change Profile Photo',
              style: AppTextStyle.h5TitleTextStyle(),
            )

            // InkWell(
          ],
        ),
      ),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return [
      AppSizeBox.width60,
      const Center(
        child: Text(
          'Profile Info',
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      const Spacer(),
      Center(
          child: InkWell(
        onTap: () {},
        child: const Text('Save',
            style: TextStyle(
                color: Colors.indigo,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
      )),
      AppSizeBox.width20,
    ];
  }
}
