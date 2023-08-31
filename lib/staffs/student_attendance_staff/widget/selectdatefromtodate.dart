import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class SelectDateFromToDate extends StatefulWidget {
  final Function(DateTime) function;
  final Function(DateTime) function1;
  const SelectDateFromToDate({
    super.key,
    required this.function,
    required this.function1,
  });

  @override
  State<SelectDateFromToDate> createState() => _SelectDateFromToDateState();
}

class _SelectDateFromToDateState extends State<SelectDateFromToDate> {
  DateTime? selectedfromdate;
  DateTime? selectedtodate;
  var startDate = TextEditingController();
  var endDate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Row(
        children: [
          Expanded(
            child: CustomContainer(
              child: TextField(
                controller: startDate,
                style: Theme.of(context).textTheme.titleSmall,
                readOnly: true,
                //maxLines: 4,
                onTap: () async {
                  selectedfromdate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2005),
                    lastDate: DateTime.now(),
                  );
                  if (selectedfromdate != null) {
                    widget.function(selectedfromdate!);
                    setState(() {
                      startDate.text =
                          "${numberList[selectedfromdate!.day]}-${numberList[selectedfromdate!.month]}-${selectedfromdate!.year}";
                    });
                  }
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () async {
                      selectedfromdate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2005),
                        lastDate: DateTime.now(),
                      );
                      if (selectedfromdate != null) {
                        widget.function(selectedfromdate!);
                        setState(() {
                          startDate.text =
                              "${numberList[selectedfromdate!.day]}-${numberList[selectedfromdate!.month]}-${selectedfromdate!.year}";
                        });
                      }
                    },
                    icon: SvgPicture.asset(
                      'assets/svg/calendar_icon.svg',
                      color: const Color(0xFF787878),
                      height: 22.0,
                    ),
                  ),
                  contentPadding: const EdgeInsets.only(top: 48.0, left: 12),
                  border: const OutlineInputBorder(),
                  label: Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.0),
                        color: const Color(0xFFE5F3FF)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          "assets/svg/calendar_icon.svg",
                          color: const Color(0xFF3E78AA),
                          height: 24.0,
                        ),
                        const SizedBox(
                          width: 6.0,
                        ),
                        Text(
                          " Start Date ",
                          style: Theme.of(context).textTheme.labelMedium!.merge(
                                const TextStyle(
                                  fontSize: 20.0,
                                  color: Color(0xFF3E78AA),
                                ),
                              ),
                        ),
                      ],
                    ),
                  ),
                  hintText: 'Select Date',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: CustomContainer(
              child: TextField(
                controller: endDate,
                readOnly: true,
                style: Theme.of(context).textTheme.titleSmall,

                //maxLines: 4,
                onTap: () async {
                  selectedtodate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2005),
                    lastDate: DateTime.now(),
                  );
                  if (selectedtodate != null) {
                    widget.function1(selectedtodate!);
                    setState(() {
                      endDate.text =
                          "${numberList[selectedtodate!.day]}-${numberList[selectedtodate!.month]}-${selectedtodate!.year}";
                    });
                  }
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.only(top: 48.0, left: 12),
                  suffixIcon: IconButton(
                    onPressed: () async {
                      selectedtodate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2005),
                        lastDate: DateTime.now(),
                      );
                      if (selectedtodate != null) {
                        widget.function1(selectedtodate!);
                        setState(() {
                          endDate.text =
                              "${numberList[selectedtodate!.day]}-${numberList[selectedtodate!.month]}-${selectedtodate!.year}";
                        });
                      }
                    },
                    icon: SvgPicture.asset(
                      'assets/svg/calendar_icon.svg',
                      color: const Color(0xFF787878),
                      height: 22.0,
                    ),
                  ),
                  border: const OutlineInputBorder(),
                  label: Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.0),
                        color: const Color(0xFFE5F3FF)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          "assets/svg/calendar_icon.svg",
                          color: const Color(0xFF3E78AA),
                          height: 24.0,
                        ),
                        const SizedBox(
                          width: 6.0,
                        ),
                        Text(
                          " End Date ",
                          style: Theme.of(context).textTheme.labelMedium!.merge(
                                const TextStyle(
                                    fontSize: 20.0, color: Color(0xFF3E78AA)),
                              ),
                        ),
                      ],
                    ),
                  ),
                  hintText: 'Select Date',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
