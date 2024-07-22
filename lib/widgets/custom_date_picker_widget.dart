import 'package:color_ado/resources/dimens.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePickerWidget extends StatefulWidget {
  const CustomDatePickerWidget({
    super.key,
    required this.onTapDate,
  });

  final Function(DateTime) onTapDate;

  @override
  State<CustomDatePickerWidget> createState() => _CustomDatePickerWidgetState();
}

class _CustomDatePickerWidgetState extends State<CustomDatePickerWidget> {
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;
  int selectedDay = DateTime.now().day;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedDate();
    });
  }

  List<DateTime> generateDates(int month, int year) {
    int daysInMonth = DateTime(year, month + 1, 0).day;
    List<DateTime> dates = List<DateTime>.generate(daysInMonth, (index) {
      return DateTime(year, month, index + 1);
    });
    return dates;
  }

  void _scrollToSelectedDate() {
    int index = selectedDay - 1;
    double position = index * 56.0;
    _scrollController.animateTo(
      position,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> dates = generateDates(selectedMonth, selectedYear);
    DateFormat dayFormat = DateFormat('dd');
    DateFormat weekDayFormat = DateFormat('EEE');

    return Column(
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kSP20x,
            ),
            child: Row(
              children: dates.map((date) {
                bool isSelected = date.day == selectedDay;
                return GestureDetector(
                  onTap: () {
                    widget.onTapDate(date);
                    setState(() {
                      selectedDay = date.day;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: kSP5x, vertical: kSP10x),
                    padding: const EdgeInsets.all(kSP15x),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(kSP10x),
                      border: Border.all(
                        color: Colors.blue,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          dayFormat.format(date),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          weekDayFormat.format(date),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
