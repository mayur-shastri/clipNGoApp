import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:time_picker_spinner/time_picker_spinner.dart';

class TimeSlot extends StatefulWidget {
  const TimeSlot({super.key});

  @override
  State<TimeSlot> createState() => _TimeSlotState();
}

class _TimeSlotState extends State<TimeSlot> {
  var selectedDate = DateTime.now();
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
                        initialDate: selectedDate,
                        onDateChange: (selectedDate) {
                          if (selectedDate.isBefore(DateTime.now())) {
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
                              this.selectedDate = selectedDate;
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
                      const Expanded(
                        child: SizedBox(),
                      ),
                      TimePickerSpinner(
                        locale: const Locale('en', ''),
                        time: selectedDate,
                        is24HourMode: false,
                        isShowSeconds: false,
                        itemHeight: 50,
                        normalTextStyle: const TextStyle(
                          fontSize: 16,
                        ),
                        highlightedTextStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.brown,
                            fontWeight: FontWeight.bold),
                        isForce2Digits: true,
                        onTimeChange: (time) {
                          if (time.isBefore(DateTime.now())) {
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  return AlertDialog(
                                    title: const Text('Error'),
                                    content: const Text(
                                        'Please select a time that is not earlier than now'),
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
                              selectedDate = time;
                            });
                          }
                        },
                      ),
                      const Expanded(
                        flex: 2,
                        child: SizedBox(),
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
