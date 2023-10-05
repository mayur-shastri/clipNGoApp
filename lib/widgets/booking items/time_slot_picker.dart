import 'package:flutter/material.dart';
import 'package:flutter_time_slot_picker/datetime_extensions.dart';

import 'package:flutter_time_slot_picker/flutter_time_slot_picker.dart';

class TimeSlotPicker extends StatefulWidget {
  const TimeSlotPicker({super.key});

  @override
  State<TimeSlotPicker> createState() => _TimeSlotPickerState();
}

class _TimeSlotPickerState extends State<TimeSlotPicker> {
  @override
  Widget build(BuildContext context) {
    bool timeSlotAvailablity = false;

    DateTime selectedStartTime = DateTime.now().roundUp(
      delta: const Duration(minutes: 30),
    );

    DateTime selectedEndTime = DateTime.now()
        .roundUp(
          delta: const Duration(minutes: 30),
        )
        .add(const Duration(minutes: 30));

    List<String> bookedSlots = [
      '11:38-12:11',
      '12:30-13:30',
      '14:0-14:30',
      '0:0-12:30',
      // '10:00-13:00',
      // '14:00-14:30',
      // '15:30-18:00',
      // '1:00-3:00'

      // "17:0-17:30",
      // "17:30-18:0",
      // "18:0-18:30",
      // "0:0-17:30"
    ];
    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      timeSlotAvailablity = checkSlotAvailablity(
          selectedStartTime, selectedEndTime, calculateSlots(bookedSlots));
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlutterTimeSlotPicker(
            height: 60,
            // ignore: prefer_const_literals_to_create_immutables
            bookedSlots: bookedSlots,
            onSlotChange: (availablity, startTime, endTime) {
              setState(() {
                timeSlotAvailablity = availablity;
                selectedStartTime = startTime;
                selectedEndTime = endTime;
              });
            },
            startTime: selectedStartTime,
            endTime: selectedEndTime,
            initialTime: DateTime.now().roundUp(
              delta: const Duration(minutes: 30),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Selected Time Slot:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            '$selectedStartTime - $selectedEndTime',
            // style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Slot Availability',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            '$timeSlotAvailablity',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
