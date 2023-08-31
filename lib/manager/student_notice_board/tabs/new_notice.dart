import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class NewNoticeTab extends StatefulWidget {
  const NewNoticeTab({super.key});

  @override
  State<NewNoticeTab> createState() => _NewNoticeTabState();
}

class _NewNoticeTabState extends State<NewNoticeTab> {
  final _controller = ScrollController();
  TextEditingController description = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  TextEditingController displayDate = TextEditingController();

  List<String> noticeType = [
    'Demo',
    'Demo1',
    'Demo2',
    'Demo3',
  ];

  List<String> noticeTitle = [
    'Demo',
    'Demo1',
    'Demo2',
    'Demo3',
  ];
  String selectedNoticeType = 'Demo';
  String selectedNoticeTitle = 'Demo1';

  RxBool wantToProvideReference = RxBool(false);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          CustomContainer(
            child: DropdownButtonFormField<String>(
                value: selectedNoticeType,
                style: Theme.of(context).textTheme.titleSmall!.merge(
                      const TextStyle(fontSize: 16.0),
                    ),
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  label: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFDFFBFE),
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/svg/noteicon.svg',
                          color: const Color.fromRGBO(40, 182, 200, 1),
                          height: 24,
                        ),
                        const SizedBox(
                          width: 6.0,
                        ),
                        Text(
                          " Notice Type ",
                          style: Theme.of(context).textTheme.labelMedium!.merge(
                                const TextStyle(
                                  fontSize: 20.0,
                                  color: Color.fromRGBO(40, 182, 200, 1),
                                ),
                              ),
                        ),
                      ],
                    ),
                  ),
                  border: const OutlineInputBorder(),
                ),
                icon: const Icon(
                  Icons.keyboard_arrow_down_outlined,
                  size: 30,
                ),
                items: List.generate(
                  noticeType.length,
                  (index) => DropdownMenuItem(
                    value: noticeType[index],
                    child: Text(
                      noticeType[index],
                      style: Theme.of(context).textTheme.labelSmall!.merge(
                          const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              letterSpacing: 0.3)),
                    ),
                  ),
                ),
                onChanged: (e) {
                  selectedNoticeType = e!;
                }),
          ),
          const SizedBox(
            height: 32,
          ),
          CustomContainer(
            child: DropdownButtonFormField<String>(
                value: selectedNoticeTitle,
                style: Theme.of(context).textTheme.titleSmall!.merge(
                      const TextStyle(fontSize: 16.0),
                    ),
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  label: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFEBEA),
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/svg/noteicon.svg',
                          color: const Color.fromRGBO(255, 111, 103, 1),
                          height: 24,
                        ),
                        const SizedBox(
                          width: 6.0,
                        ),
                        Text(
                          " Notice Title ",
                          style: Theme.of(context).textTheme.labelMedium!.merge(
                                const TextStyle(
                                  fontSize: 20.0,
                                  color: Color.fromRGBO(255, 111, 103, 1),
                                ),
                              ),
                        ),
                      ],
                    ),
                  ),
                  border: const OutlineInputBorder(),
                ),
                icon: const Icon(
                  Icons.keyboard_arrow_down_outlined,
                  size: 30,
                ),
                items: List.generate(
                  noticeType.length,
                  (index) => DropdownMenuItem(
                    value: noticeTitle[index],
                    child: Text(
                      noticeTitle[index],
                      style: Theme.of(context).textTheme.labelSmall!.merge(
                          const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              letterSpacing: 0.3)),
                    ),
                  ),
                ),
                onChanged: (e) {
                  selectedNoticeTitle = e!;
                }),
          ),
          const SizedBox(
            height: 32,
          ),
          CustomContainer(
            child: TextField(
              style: Theme.of(context).textTheme.titleSmall,
              controller: description,
              maxLines: 5,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                label: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFDBFDF5),
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        "assets/svg/file-text.svg",
                        color: const Color.fromRGBO(71, 186, 158, 1),
                        height: 24,
                      ),
                      const SizedBox(
                        width: 6.0,
                      ),
                      Text(
                        " Description ",
                        style: Theme.of(context).textTheme.labelMedium!.merge(
                              const TextStyle(
                                fontSize: 20.0,
                                color: Color.fromRGBO(71, 186, 158, 1),
                              ),
                            ),
                      ),
                    ],
                  ),
                ),
                hintText: 'Enter here.',
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
          const SizedBox(
            height: 32,
          ),
          CustomContainer(
            child: TextField(
              controller: startDate,
              style: Theme.of(context).textTheme.titleSmall,
              readOnly: true,
              //maxLines: 4,
              onTap: () async {
                var date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2023),
                  lastDate: DateTime(2025),
                );
                if (date != null) {
                  setState(() {
                    startDate.text =
                        "${numberList[date.day]}-${numberList[date.month]}-${date.year}";
                  });
                }
              },
              decoration: InputDecoration(
                suffixIcon: const Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.grey,
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
          const SizedBox(
            height: 32,
          ),
          CustomContainer(
            child: TextField(
              controller: startDate,
              style: Theme.of(context).textTheme.titleSmall,
              readOnly: true,
              //maxLines: 4,
              onTap: () async {
                var date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2023),
                  lastDate: DateTime(2025),
                );
                if (date != null) {
                  setState(() {
                    endDate.text =
                        "${numberList[date.day]}-${numberList[date.month]}-${date.year}";
                  });
                }
              },
              decoration: InputDecoration(
                suffixIcon: const Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.grey,
                ),
                contentPadding: const EdgeInsets.only(top: 48.0, left: 12),
                border: const OutlineInputBorder(),
                label: Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      color: const Color(0xFFEEE8FF)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        "assets/svg/calendar_icon.svg",
                        color: const Color(0xFF6F58B4),
                        height: 24.0,
                      ),
                      const SizedBox(
                        width: 6.0,
                      ),
                      Text(
                        " End Date ",
                        style: Theme.of(context).textTheme.labelMedium!.merge(
                              const TextStyle(
                                fontSize: 20.0,
                                color: Color(0xFF6F58B4),
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
          const SizedBox(
            height: 32,
          ),
          CustomContainer(
            child: TextField(
              controller: startDate,
              style: Theme.of(context).textTheme.titleSmall,
              readOnly: true,
              //maxLines: 4,
              onTap: () async {
                var date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2023),
                  lastDate: DateTime(2025),
                );
                if (date != null) {
                  setState(() {
                    endDate.text =
                        "${numberList[date.day]}-${numberList[date.month]}-${date.year}";
                  });
                }
              },
              decoration: InputDecoration(
                suffixIcon: const Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.grey,
                ),
                contentPadding: const EdgeInsets.only(top: 48.0, left: 12),
                border: const OutlineInputBorder(),
                label: Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      color: const Color(0xFFFFFCE1)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        "assets/svg/calendar_icon.svg",
                        color: const Color(0xFFBBAC2C),
                        height: 24.0,
                      ),
                      const SizedBox(
                        width: 6.0,
                      ),
                      Text(
                        " Display Date ",
                        style: Theme.of(context).textTheme.labelMedium!.merge(
                              const TextStyle(
                                fontSize: 20.0,
                                color: Color(0xFFBBAC2C),
                              ),
                            ),
                      ),
                    ],
                  ),
                ),
                hintText: '(Optional)',
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
          const SizedBox(
            height: 14.0,
          ),
          // ReferencesWidget(wantToProvideReference: wantToProvideReference, hwCwController: ,),
          const SizedBox(
            height: 16.0,
          ),
          // const AttachedFiles(),
          const SizedBox(
            height: 32.0,
          ),
          CustomContainer(
            child: DropdownButtonFormField<String>(
                value: selectedNoticeType,
                style: Theme.of(context).textTheme.titleSmall!.merge(
                      const TextStyle(fontSize: 16.0),
                    ),
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  label: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 235, 234, 1),
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/classnew.png',
                          height: 22,
                        ),
                        const SizedBox(
                          width: 6.0,
                        ),
                        Text(
                          " Class Name ",
                          style: Theme.of(context).textTheme.labelMedium!.merge(
                                const TextStyle(
                                  fontSize: 20.0,
                                  color: Color.fromRGBO(255, 111, 103, 1),
                                ),
                              ),
                        ),
                      ],
                    ),
                  ),
                  border: const OutlineInputBorder(),
                ),
                icon: const Icon(
                  Icons.keyboard_arrow_down_outlined,
                  size: 30,
                ),
                items: List.generate(
                  noticeType.length,
                  (index) => DropdownMenuItem(
                    value: noticeType[index],
                    child: Text(
                      noticeType[index],
                      style: Theme.of(context).textTheme.labelSmall!.merge(
                          const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              letterSpacing: 0.3)),
                    ),
                  ),
                ),
                onChanged: (e) {
                  selectedNoticeType = e!;
                }),
          ),
          const SizedBox(
            height: 32,
          ),
          CustomContainer(
            child: DropdownButtonFormField<String>(
                value: selectedNoticeType,
                style: Theme.of(context).textTheme.titleSmall!.merge(
                      const TextStyle(fontSize: 16.0),
                    ),
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  label: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFDBFDF5),
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/sectionnew.png',
                          height: 22,
                        ),
                        const SizedBox(
                          width: 6.0,
                        ),
                        Text(
                          " Select Section ",
                          style: Theme.of(context).textTheme.labelMedium!.merge(
                                const TextStyle(
                                  fontSize: 20.0,
                                  color: Color.fromRGBO(71, 186, 158, 1),
                                ),
                              ),
                        ),
                      ],
                    ),
                  ),
                  border: const OutlineInputBorder(),
                ),
                icon: const Icon(
                  Icons.keyboard_arrow_down_outlined,
                  size: 30,
                ),
                items: List.generate(
                  noticeType.length,
                  (index) => DropdownMenuItem(
                    value: noticeType[index],
                    child: Text(
                      noticeType[index],
                      style: Theme.of(context).textTheme.labelSmall!.merge(
                          const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              letterSpacing: 0.3)),
                    ),
                  ),
                ),
                onChanged: (e) {
                  selectedNoticeType = e!;
                }),
          ),
          const SizedBox(
            height: 32,
          ),
          CustomContainer(
            child: DropdownButtonFormField<String>(
                value: selectedNoticeType,
                style: Theme.of(context).textTheme.titleSmall!.merge(
                      const TextStyle(fontSize: 16.0),
                    ),
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  label: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(229, 243, 255, 1),
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/tabprofile.png',
                          color: const Color.fromRGBO(62, 120, 170, 1),
                          height: 26,
                        ),
                        const SizedBox(
                          width: 6.0,
                        ),
                        Text(
                          " Select Students ",
                          style: Theme.of(context).textTheme.labelMedium!.merge(
                                const TextStyle(
                                  fontSize: 20.0,
                                  color: Color.fromRGBO(62, 120, 170, 1),
                                ),
                              ),
                        ),
                      ],
                    ),
                  ),
                  border: const OutlineInputBorder(),
                ),
                icon: const Icon(
                  Icons.keyboard_arrow_down_outlined,
                  size: 30,
                ),
                items: List.generate(
                  noticeType.length,
                  (index) => DropdownMenuItem(
                    value: noticeType[index],
                    child: Text(
                      noticeType[index],
                      style: Theme.of(context).textTheme.labelSmall!.merge(
                          const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              letterSpacing: 0.3)),
                    ),
                  ),
                ),
                onChanged: (e) {
                  selectedNoticeType = e!;
                }),
          ),
          const SizedBox(
            height: 64,
          ),
          MSkollBtn(
            title: "Save Details",
            onPress: () {},
            size: Size(Get.width * 0.4, 50),
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }
}
