import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:time_picker_spinner/time_picker_spinner.dart';
import 'package:salon_app/widgets/booking items/time_slot_pickers.dart';
import 'package:intl/intl.dart';

class TimeSlot extends StatefulWidget {
  const TimeSlot({super.key});

  @override
  State<TimeSlot> createState() => _TimeSlotState();
}

class _TimeSlotState extends State<TimeSlot> {
  var selectedDateAndTime = DateTime.now();
  var chosenDate = DateTime.now();
  var chosenTime = DateTime.now();
  String _selectedTime = '9:00';
  void updateSelectedTime(String time) {
    _selectedTime = time;
    chosenTime = DateFormat('HH:mm:ss').parse('$time:00');
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        await showDialog(
            context: context,
            builder: (ctx) {
              return Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const Expanded(
                        child: SizedBox(),
                      ),
                      Text(
                        'Pick preferred date',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      EasyDateTimeLine(
                        initialDate: chosenDate,
                        onDateChange: (selectedDate) {
                          if (selectedDate.isBefore(
                              DateTime.now().subtract(Duration(days: 1)))) {
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  return AlertDialog(
                                    title: const Text('Error'),
                                    content: const Text(
                                        'Please select a date that is not earlier than today'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                });
                          } else {
                            setState(() {
                              chosenDate = selectedDate;
                            });
                          }
                        },
                        headerProps: const EasyHeaderProps(
                          monthPickerType: MonthPickerType.switcher,
                          selectedDateFormat: SelectedDateFormat.fullDateDMY,
                        ),
                        dayProps: const EasyDayProps(
                          width: 70,
                          height: 70,
                          dayStructure: DayStructure.dayStrDayNum,
                          activeDayStyle: DayStyle(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromARGB(255, 113, 54, 22),
                                  Color.fromARGB(255, 220, 166, 132),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      Text(
                        'Pick preferred time',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        flex: 6,
                        child: TimeSlotPicker(
                          updateTime: updateSelectedTime,
                          time: _selectedTime,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              selectedDateAndTime = DateTime(
                                  chosenDate.year,
                                  chosenDate.month,
                                  chosenDate.day,
                                  chosenTime.hour,
                                  chosenTime.minute,
                                  chosenTime.second);
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            });
      },
      icon: const Icon(Icons.lock_clock),
      label: const Text('Time Slot'),
    );
  }
}
