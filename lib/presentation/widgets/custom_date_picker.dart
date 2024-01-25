import 'package:flutter/material.dart';

class CustomeDatePicker extends StatelessWidget {
  final String title;
  final DateTime? selectedDate;
  TextEditingController dobController;
  final ValueChanged<DateTime> onDateChanged;

  CustomeDatePicker(
      {required this.title,
      required this.selectedDate,
      required this.onDateChanged,
      required this.dobController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(
          height: 6,
        ),
        SizedBox(
          height: 60,
          child: TextFormField(
            controller: dobController,
            keyboardType: TextInputType.datetime,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              hintText: 'yyyy-mm-dd',
              suffix: IconButton(
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: dobController.text.isNotEmpty
                          ?
                          //only date
                          DateTime.parse(dobController.text)
                          : selectedDate ?? DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (date != null) {
                      onDateChanged(date);
                    }
                  },
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                  )),
            ),
            onChanged: (value) {
              //convert this String to DateTime
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter $title';
              }
              // must in yyyy-mm-dd format
              if (!value.contains('-')) {
                return 'Please enter in yyyy-mm-dd format';
              }
              // after that also month and day
              if (value.split('-').length != 3) {
                return 'Please enter in yyyy-mm-dd format';
              }
              //also value after that

              if (value.split('-')[0].length != 4) {
                return 'Please enter DOB in yyyy-mm-dd format';
              }
              if (value.split('-')[1].length != 2) {
                return 'Please enter in yyyy-mm-dd format';
              }
              if (value.split('-')[2].length != 2) {
                return 'Please enter in yyyy-mm-dd format';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
