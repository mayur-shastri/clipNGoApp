import 'package:flutter/material.dart';

class TimeSlotPicker extends StatefulWidget {
  const TimeSlotPicker(
      {super.key, required this.updateTime, required this.time});
  final Function updateTime;
  final String time;
  @override
  State<TimeSlotPicker> createState() => _TimeSlotPickerState();
}

class _TimeSlotPickerState extends State<TimeSlotPicker> {
  String selectedTime = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedTime = widget.time;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 200,
      width: double.infinity,
      child: GridView.count(
        childAspectRatio: 20 / 15,
        crossAxisCount: 3,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                selectedTime = '9:00';
              });
              widget.updateTime(selectedTime);
            },
            child: Container(
              decoration: BoxDecoration(
                color: selectedTime == '9:00'
                    ? Colors.brown[300]
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(15),
              ),
              margin: const EdgeInsets.all(10),
              child: const Center(child: Text('9:00')),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                selectedTime = '10:00';
              });
              widget.updateTime(selectedTime);
            },
            child: Container(
              decoration: BoxDecoration(
                color: selectedTime == '10:00'
                    ? Colors.brown[300]
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(15),
              ),
              margin: const EdgeInsets.all(10),
              child: const Center(child: Text('10:00')),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                selectedTime = '11:00';
              });
              widget.updateTime(selectedTime);
            },
            child: Container(
              decoration: BoxDecoration(
                color: selectedTime == '11:00'
                    ? Colors.brown[300]
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(15),
              ),
              margin: const EdgeInsets.all(10),
              child: const Center(child: Text('11:00')),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                selectedTime = '12:00';
              });
              widget.updateTime(selectedTime);
            },
            child: Container(
              decoration: BoxDecoration(
                color: selectedTime == '12:00'
                    ? Colors.brown[300]
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(15),
              ),
              margin: const EdgeInsets.all(10),
              child: const Center(child: Text('12:00')),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                selectedTime = '13:00';
              });
              widget.updateTime(selectedTime);
            },
            child: Container(
              decoration: BoxDecoration(
                color: selectedTime == '13:00'
                    ? Colors.brown[300]
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(15),
              ),
              margin: const EdgeInsets.all(10),
              child: const Center(child: Text('13:00')),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                selectedTime = '14:00';
              });
              widget.updateTime(selectedTime);
            },
            child: Container(
              decoration: BoxDecoration(
                color: selectedTime == '14:00'
                    ? Colors.brown[300]
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(15),
              ),
              margin: const EdgeInsets.all(10),
              child: const Center(child: Text('14:00')),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                selectedTime = '15:00';
              });
              widget.updateTime(selectedTime);
            },
            child: Container(
              decoration: BoxDecoration(
                color: selectedTime == '15:00'
                    ? Colors.brown[300]
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(15),
              ),
              margin: const EdgeInsets.all(10),
              child: const Center(child: Text('15:00')),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                selectedTime = '16:00';
              });
              widget.updateTime(selectedTime);
            },
            child: Container(
              decoration: BoxDecoration(
                color: selectedTime == '16:00'
                    ? Colors.brown[300]
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(15),
              ),
              margin: const EdgeInsets.all(10),
              child: const Center(child: Text('16:00')),
            ),
          ),
        ],
      ),
    );
  }
}
