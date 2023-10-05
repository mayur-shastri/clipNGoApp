import 'package:flutter/material.dart';
import 'package:salon_app/widgets/booking%20items/time_slot_picker.dart';

class TimeSlot extends StatelessWidget {
  const TimeSlot({super.key});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: () async {
          await showDialog(
              context: context,
              builder: (ctx) {
                return Dialog(
                  child: TimeSlotPicker(),
                );
              });
        },
        icon: Icon(Icons.lock_clock),
        label: Text('Time Slot'));
  }
}
