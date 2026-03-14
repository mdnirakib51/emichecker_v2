import 'dart:developer';
import 'package:flutter/material.dart';
import '../constants/date_time_formatter.dart';

Future<DateTime> showDateOnlyPicker(
    BuildContext context,
    ) async {
  DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2080),
  );
  return selectedDate ?? DateTime.now();
}

Future<TimeOfDay?> showTimeOnlyPicker(
    BuildContext context,
    ) async {
  TimeOfDay? selectedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
  return selectedTime ?? TimeOfDay.now();
}

Future<String> showDateTimePicker(context) async {
  TimeOfDay? selectedTime;
  DateTime? selectedDate;
  selectedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2030),
  );

  if(selectedDate != null){
    selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now()
    );
  }else{
    selectedTime = TimeOfDay.now();
  }

  String formatedDate = DateTimeFormatter.showDateOnly.format(selectedDate ?? DateTime.now());
  var formatedTime = selectedTime?.format(context);

  log("Here is the date : $formatedDate");
  log("Here is the time : $formatedTime");
  String? formatedDateTime = "$formatedDate ${formatedTime.toString()}";
  log("Here is the date & time : $formatedDateTime");

  return formatedDateTime;
}

// Month-only picker function
Future<DateTime> showOnlyMonthPicker(BuildContext context) async {
  DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2080),
    // This will show the month/year picker initially
    initialDatePickerMode: DatePickerMode.year,
    // Optional: You can customize the help text
    helpText: 'Select Month',
    // Optional: Customize field labels
    fieldLabelText: 'Enter month',
    fieldHintText: 'mm/yyyy',
  );

  return selectedDate ?? DateTime.now();
}

// Alternative: Custom Month Picker Widget
Future<DateTime?> showCustomMonthPicker(BuildContext context) async {
  DateTime selectedDate = DateTime.now();

  return await showDialog<DateTime>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Select Month'),
      content: SizedBox(
        height: 300,
        width: 300,
        child: YearPicker(
          firstDate: DateTime(2000),
          lastDate: DateTime(2080),
          selectedDate: selectedDate,
          onChanged: (DateTime dateTime) {
            selectedDate = DateTime(dateTime.year, dateTime.month);
            Navigator.pop(context, selectedDate);
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, selectedDate),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}