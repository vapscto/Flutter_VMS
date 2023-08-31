import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/config/themes/theme_data.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/notice/api/get_datewise_notices.dart';
import 'package:m_skool_flutter/notice/api/get_notice_api.dart';
import 'package:m_skool_flutter/notice/api/get_syllabus_api.dart';
import 'package:m_skool_flutter/notice/api/get_tt_notice_api.dart';
import 'package:m_skool_flutter/notice/model/notice_data_model.dart';
import 'package:m_skool_flutter/notice/screen/notice_detail_screen.dart';
import 'package:m_skool_flutter/notice/widget/notice_filtered_widget.dart';
import 'package:m_skool_flutter/student/information/controller/hwcwnb_controller.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_back_btn.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';
import 'package:m_skool_flutter/widget/home_fab.dart';
import 'package:url_launcher/url_launcher.dart';

class NoticeHome extends StatefulWidget {
  final String? appBarTitle;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final HwCwNbController hwCwNbController;
  const NoticeHome({
    super.key,
    this.appBarTitle,
    required this.loginSuccessModel,
    required this.mskoolController,
    required this.hwCwNbController,
  });

  @override
  State<NoticeHome> createState() => _NoticeHomeState();
}

class _NoticeHomeState extends State<NoticeHome> {
  int color = -1;
  List<Color> usedColor = [];

  final HwCwNbController hwCwNbController = Get.put(HwCwNbController());
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    Get.delete<HwCwNbController>();
    super.dispose();
  }

  RxBool showFilter = RxBool(false);
  RxString noticeType = RxString("others");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const HomeFab(),
      appBar: widget.appBarTitle != null
          ? AppBar(
              elevation: 0,
              centerTitle: false,
              leading: const CustomGoBackButton(),
              leadingWidth: 30,
              title: Text(widget.appBarTitle!),
              actions: [
                IconButton(
                  onPressed: () {
                    if (scrollController.offset > 0 && showFilter.value) {
                      scrollController.animateTo(0,
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.fastOutSlowIn);
                      return;
                    }

                    if (showFilter.value) {
                      showFilter.value = false;
                    } else {
                      showFilter.value = true;
                    }

                    // setState(() {});

                    scrollController.animateTo(0,
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.fastOutSlowIn);
                  },
                  icon: SvgPicture.asset('assets/svg/filter.svg'),
                ),
              ],
            )
          : null,
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            Obx(() {
              return showFilter.value == false
                  ? const SizedBox()
                  : Container(
                      color: Theme.of(context).primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          right: 16.0,
                          bottom: 16.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Filter",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .merge(const TextStyle(color: Colors.white)),
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () async {
                                      DateTime firstDate = DateTime(
                                        DateTime.now().month == 1
                                            ? DateTime.now().year - 1
                                            : DateTime.now().year,
                                        DateTime.now().month == 1
                                            ? 12
                                            : DateTime.now().day == 1
                                                ? DateTime.now().month - 1
                                                : DateTime.now().month,
                                      );

                                      DateTime endDate = DateTime.now();
                                      if (hwCwNbController.dtList.length > 1) {
                                        endDate = hwCwNbController.dtList.last;
                                      }
                                      final DateTime? startDate =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: hwCwNbController
                                                      .dtList.isNotEmpty
                                                  ? hwCwNbController
                                                      .dtList.first
                                                  : DateTime.now(),
                                              firstDate: DateTime(
                                                  DateTime.now().year - 5),
                                              lastDate: endDate);
                                      if (startDate == null) {
                                        Fluttertoast.showToast(
                                            msg: "Please select start date");
                                        return;
                                      }
                                      hwCwNbController
                                          .updateStartDateProvided(true);
                                      if (hwCwNbController.dtList.isEmpty) {
                                        hwCwNbController.updateStartBy(
                                            "${startDate.day}-${startDate.month}-${startDate.year}");
                                        hwCwNbController.dtList.add(startDate);
                                      }

                                      if (hwCwNbController.dtList.length == 1) {
                                        hwCwNbController.dtList.first =
                                            startDate;
                                        hwCwNbController.updateStartBy(
                                            "${startDate.day}-${startDate.month}-${startDate.year}");
                                      }

                                      if (hwCwNbController.dtList.length > 1) {
                                        hwCwNbController.dtList.first =
                                            startDate;
                                        hwCwNbController.updateStartBy(
                                            "${startDate.day}-${startDate.month}-${startDate.year}");
                                        hwCwNbController.updateShowFilter(
                                            hwCwNbController.filter.value + 1);
                                        showFilter.value = false;

                                        Fluttertoast.showToast(
                                            msg:
                                                "Filter Applied.. now you will see the filtered result");
                                        await filter();
                                      }
                                      //hwCwNbController.dtList.add(startDate);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 12.0, right: 8.0),
                                      alignment: Alignment.centerLeft,
                                      width: double.infinity,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: Builder(builder: (context) {
                                        return Obx(() {
                                          return Text(
                                            hwCwNbController.startBy.value,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          );
                                        });
                                      }),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 16.0,
                                ),
                                Expanded(
                                    child: InkWell(
                                  onTap: () async {
                                    if (!hwCwNbController
                                        .startDateProvided.value) {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Please provide start date before selecting end date");
                                      return;
                                    }
                                    DateTime firstDate = DateTime(
                                      DateTime.now().month == 1
                                          ? DateTime.now().year - 1
                                          : DateTime.now().year,
                                      DateTime.now().month == 1
                                          ? 12
                                          : DateTime.now().day == 1
                                              ? DateTime.now().month - 1
                                              : DateTime.now().month,
                                    );
                                    firstDate = hwCwNbController.dtList.first;
                                    final DateTime? endDate =
                                        await showDatePicker(
                                            context: context,
                                            initialDate: hwCwNbController
                                                        .dtList.isNotEmpty &&
                                                    hwCwNbController
                                                            .dtList.length >
                                                        1
                                                ? hwCwNbController.dtList.last
                                                : DateTime.now(),
                                            firstDate: firstDate,
                                            lastDate: DateTime.now());

                                    if (endDate == null) {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Please select end date to start filter");
                                      return;
                                    }

                                    if (hwCwNbController.dtList.first.day >
                                            endDate.day &&
                                        hwCwNbController.dtList.first.month >
                                            endDate.month) {
                                      Fluttertoast.showToast(
                                          msg:
                                              "End Date must not be less than start date");
                                      return;
                                    }
                                    hwCwNbController.updateEndby(
                                        "${endDate.day}-${endDate.month}-${endDate.year}");
                                    hwCwNbController.dtList.add(endDate);

                                    // hwCwNbController
                                    //     .updateStartDateProvided(false);
                                    // hwCwNbController.updateStartBy("Start Date");
                                    // hwCwNbController.updateEndby("End Date");

                                    hwCwNbController.dtList.add(endDate);
                                    hwCwNbController.updateShowFilter(
                                        hwCwNbController.filter.value + 1);
                                    showFilter.value = false;

                                    Fluttertoast.showToast(
                                        msg:
                                            "Filter Applied.. now you will see the filtered result");

                                    await filter();
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0,
                                    ),
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Obx(() {
                                      return Text(
                                        hwCwNbController.endBy.value,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      );
                                    }),
                                  ),
                                ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
            }),
            const SizedBox(
              height: 12.0,
            ),
            Obx(() {
              return hwCwNbController.filter.value == 0
                  ? Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Obx(() {
                                return Theme(
                                  data: ThemeData(
                                    unselectedWidgetColor:
                                        Theme.of(context).primaryColor,
                                  ),
                                  child: Radio(
                                      activeColor:
                                          Theme.of(context).primaryColor,
                                      value: "others",
                                      groupValue: noticeType.value,
                                      onChanged: (type) {
                                        noticeType.value = type!;
                                      }),
                                );
                              }),
                              Text(
                                "Others",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Obx(() {
                                return Theme(
                                  data: ThemeData(
                                    unselectedWidgetColor:
                                        Theme.of(context).primaryColor,
                                  ),
                                  child: Radio(
                                      value: "syllabus",
                                      activeColor:
                                          Theme.of(context).primaryColor,
                                      groupValue: noticeType.value,
                                      onChanged: (type) {
                                        noticeType.value = type!;
                                      }),
                                );
                              }),
                              Text(
                                "Syllabus",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Obx(() {
                                return Theme(
                                  data: ThemeData(
                                      unselectedWidgetColor:
                                          Theme.of(context).primaryColor),
                                  child: Radio(
                                      value: "timetable",
                                      activeColor:
                                          Theme.of(context).primaryColor,
                                      groupValue: noticeType.value,
                                      onChanged: (type) {
                                        noticeType.value = type!;
                                      }),
                                );
                              }),
                              Text(
                                "Timetable",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : const SizedBox();
            }),
            Obx(() {
              return hwCwNbController.filter > 0
                  ? NoticeFilteredWidget(
                      loginSuccessModel: widget.loginSuccessModel,
                      mskoolController: widget.mskoolController,
                      hwCwNbController: hwCwNbController)
                  : Obx(() {
                      return noticeType.value == "others"
                          ? FutureBuilder<List<NoticeDataModelValues>>(
                              future: GetNoticeApi.instance.getNotice(
                                miId: widget.loginSuccessModel.mIID!,
                                asmayId: widget.loginSuccessModel.asmaYId!,
                                amstId: widget.loginSuccessModel.amsTId!,
                                baseUrl: baseUrlFromInsCode(
                                  "portal",
                                  widget.mskoolController,
                                ),
                              ),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data!.isEmpty) {
                                    return const Center(
                                      child: AnimatedProgressWidget(
                                        animationPath:
                                            'assets/json/nodata.json',
                                        title: "No Syllabus found",
                                        desc:
                                            "There is no syllabus present currently",
                                        animatorHeight: 250,
                                      ),
                                    );
                                  }
                                  return ListView.separated(
                                    padding: const EdgeInsets.all(16.0),
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (_, index) {
                                      color += 1;
                                      if (index % 6 == 0) {
                                        color = 0;
                                      }
                                      if (color > 6) {
                                        color = 0;
                                      }

                                      usedColor
                                          .add(noticeColor.elementAt(color));

                                      return InkWell(
                                        onTap: () {
                                          logger.d(color);

                                          Get.to(() => NoticeDetailScreen(
                                                color:
                                                    usedColor.elementAt(index),
                                                value: snapshot.data!
                                                    .elementAt(index),
                                                isFiltring: false,
                                                forSyllabus: false,
                                                base: baseUrlFromInsCode(
                                                    "portal",
                                                    widget.mskoolController),
                                              ));
                                        },
                                        child: NoticeItem(
                                          color: color,
                                          values:
                                              snapshot.data!.elementAt(index),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (_, index) {
                                      return const SizedBox(
                                        height: 16.0,
                                      );
                                    },
                                    itemCount: snapshot.data!.length,
                                  );
                                }
                                if (snapshot.hasError) {
                                  return ErrWidget(
                                      err: snapshot.error
                                          as Map<String, dynamic>);
                                }
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: Get.height * 0.25,
                                    ),
                                    const AnimatedProgressWidget(
                                        title: "Loading Notice's",
                                        desc:
                                            "Don't Worry we are fetching notice's from noticeboard",
                                        animationPath:
                                            "assets/json/Noticeboard.json"),
                                  ],
                                );
                                // return const CustomPgrWidget(
                                //     title: "",
                                //     desc:
                                //         "");
                              })
                          : noticeType.value == "syllabus"
                              ? SyllabusNotices(
                                  loginSuccessModel: widget.loginSuccessModel,
                                  mskoolController: widget.mskoolController,
                                )
                              : TTNotice(
                                  loginSuccessModel: widget.loginSuccessModel,
                                  mskoolController: widget.mskoolController);
                    });
            }),
          ],
        ),
      ),
    );
  }

  Future<void> filter() async {
    await GetDateWiseNotice.instance.getNotices(
      miId: widget.loginSuccessModel.mIID!,
      asmayId: widget.loginSuccessModel.asmaYId!,
      amstId: widget.loginSuccessModel.amsTId!,
      startDate: hwCwNbController.dtList.first.toLocal().toString(),
      endDate: hwCwNbController.dtList.last.toLocal().toString(),
      nbController: hwCwNbController,
      base: baseUrlFromInsCode(
        "portal",
        widget.mskoolController,
      ),
    );
  }
}

class SyllabusNotices extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const SyllabusNotices({
    Key? key,
    required this.loginSuccessModel,
    required this.mskoolController,
  }) : super(key: key);

  @override
  State<SyllabusNotices> createState() => _SyllabusNoticesState();
}

class _SyllabusNoticesState extends State<SyllabusNotices> {
  int color = -1;
  List<Color> usedColor = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NoticeDataModelValues>>(
        future: GetSyllabusApi.instance.loadSyllabusNotice(
            amstId: widget.loginSuccessModel.amsTId!,
            miId: widget.loginSuccessModel.mIID!,
            asmayId: widget.loginSuccessModel.asmaYId!,
            userId: widget.loginSuccessModel.userId!,
            roleId: widget.loginSuccessModel.roleId!,
            flag: "S",
            base: baseUrlFromInsCode("portal", widget.mskoolController)),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: AnimatedProgressWidget(
                  animationPath: 'assets/json/nodata.json',
                  title: "No Syllabus found",
                  desc: "There is no syllabus present currently",
                  animatorHeight: 250,
                ),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16.0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                color += 1;
                if (index % 6 == 0) {
                  color = 0;
                }
                if (color > 6) {
                  color = 0;
                }

                usedColor.add(noticeColor.elementAt(color));

                return InkWell(
                  onTap: () {
                    //logger.d(color);

                    Get.to(() => NoticeDetailScreen(
                          color: usedColor.elementAt(index),
                          value: snapshot.data!.elementAt(index),
                          isFiltring: false,
                          forSyllabus: true,
                          base: baseUrlFromInsCode(
                              "portal", widget.mskoolController),
                        ));
                  },
                  child: NoticeItem(
                    color: color,
                    values: snapshot.data!.elementAt(index),
                  ),
                );
              },
              separatorBuilder: (_, index) {
                return const SizedBox(
                  height: 16.0,
                );
              },
              itemCount: snapshot.data!.length,
            );
          }
          if (snapshot.hasError) {
            return ErrWidget(err: snapshot.error as Map<String, dynamic>);
          }
          return Column(
            children: [
              SizedBox(
                height: Get.height * 0.25,
              ),
              const AnimatedProgressWidget(
                  title: "Loading Syllabus Notice",
                  desc:
                      "Don't Worry we are fetching syllabus notice's from noticeboard",
                  animationPath: "assets/json/Noticeboard.json"),
            ],
          );
        });
  }
}

class TTNotice extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const TTNotice(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<TTNotice> createState() => _TTNoticeState();
}

class _TTNoticeState extends State<TTNotice> {
  int color = -1;
  List<Color> usedColor = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NoticeDataModelValues>>(
        future: GetTTNoticeApi.instance.loadTTNotices(
            amstId: widget.loginSuccessModel.amsTId!,
            miId: widget.loginSuccessModel.mIID!,
            asmayId: widget.loginSuccessModel.asmaYId!,
            userId: widget.loginSuccessModel.userId!,
            roleId: widget.loginSuccessModel.roleId!,
            flag: "TT",
            base: baseUrlFromInsCode("portal", widget.mskoolController)),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: AnimatedProgressWidget(
                  animationPath: 'assets/json/nodata.json',
                  title: "No Timetable found",
                  desc: "There is no timetable present currently",
                  animatorHeight: 250,
                ),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16.0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                color += 1;
                if (index % 6 == 0) {
                  color = 0;
                }
                if (color > 6) {
                  color = 0;
                }

                usedColor.add(noticeColor.elementAt(color));

                return TTNoticeItem(
                  color: color,
                  values: snapshot.data!.elementAt(index),
                );
              },
              separatorBuilder: (_, index) {
                return const SizedBox(
                  height: 16.0,
                );
              },
              itemCount: snapshot.data!.length,
            );
          }
          if (snapshot.hasError) {
            return ErrWidget(err: snapshot.error as Map<String, dynamic>);
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.height * 0.25,
              ),
              const AnimatedProgressWidget(
                  title: "Loading Timetable Notice",
                  desc:
                      "Don't Worry we are fetching timetable notice's from noticeboard",
                  animationPath: "assets/json/Noticeboard.json"),
            ],
          );
        });
  }
}

class NoticeItem extends StatelessWidget {
  const NoticeItem({
    Key? key,
    required this.color,
    required this.values,
  }) : super(key: key);

  final int color;
  final NoticeDataModelValues values;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: CustomThemeData.getShadow(),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          //color: colors.elementAt(color).withOpacity(0.1),
          //boxShadow: CustomThemeData.getShadow(),
        ),
        child: Row(
          children: [
            Container(
              height: 90,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: noticeBackgroundColor.elementAt(color),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      values.intBStartDate == null
                          ? "N/a"
                          : "${DateTime.parse(values.intBStartDate!).day}",
                      style: Theme.of(context).textTheme.titleMedium!.merge(
                            TextStyle(
                              color: noticeColor.elementAt(color),
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      values.intBStartDate == null
                          ? "N/a"
                          : shortMonth.elementAt(
                              (DateTime.parse(values.intBStartDate!).month) -
                                  1),
                      style: Theme.of(context).textTheme.labelMedium!.merge(
                          TextStyle(color: noticeColor.elementAt(color))),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      values.intBTitle ?? "N/a",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall!.merge(
                          const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16)),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/svg/calendar.svg',
                          color: Theme.of(context).textTheme.titleMedium!.color,
                        ),
                        const SizedBox(
                          width: 6.0,
                        ),
                        Text(
                          values.intBStartDate == null ||
                                  values.intBEndDate == null
                              ? "N/a"
                              : ''' ${getFormatedDate(DateTime.parse(values.intBStartDate!))} - ${getFormatedDate(DateTime.parse(values.intBEndDate!))} ''',
                          style: Theme.of(context).textTheme.labelSmall!.merge(
                                const TextStyle(
                                    letterSpacing: 0.3, fontSize: 15.0),
                              ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 80,
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                Icons.chevron_right_rounded,
                size: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TTNoticeItem extends StatelessWidget {
  final int color;
  final NoticeDataModelValues values;
  const TTNoticeItem({super.key, required this.color, required this.values});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: CustomThemeData.getShadow(),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          //color: colors.elementAt(color).withOpacity(0.1),
          //boxShadow: CustomThemeData.getShadow(),
        ),
        child: Row(
          children: [
            Container(
              height: 90,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: noticeColor.elementAt(color).withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      values.intBStartDate == null
                          ? "N/a"
                          : "${DateTime.parse(values.intBStartDate!).day}",
                      style: Theme.of(context).textTheme.titleMedium!.merge(
                            TextStyle(
                              color: noticeColor.elementAt(color),
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      values.intBStartDate == null
                          ? "N/a"
                          : shortMonth.elementAt(
                              (DateTime.parse(values.intBStartDate!).month) -
                                  1),
                      style: Theme.of(context).textTheme.labelMedium!.merge(
                          TextStyle(color: noticeColor.elementAt(color))),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      values.intBTitle ?? "N/a",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall!.merge(
                          const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16)),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/svg/calendar.svg',
                          color: Theme.of(context).textTheme.titleMedium!.color,
                        ),
                        const SizedBox(
                          width: 6.0,
                        ),
                        Text(
                          values.intBStartDate == null ||
                                  values.intBEndDate == null
                              ? "N/a"
                              : ''' ${getFormatedDate(DateTime.parse(values.intBStartDate!))} - ${getFormatedDate(DateTime.parse(values.intBEndDate!))} ''',
                          style: Theme.of(context).textTheme.labelSmall!.merge(
                                const TextStyle(
                                    letterSpacing: 0.3, fontSize: 15.0),
                              ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                if (values.iNTBFLFileName == null ||
                    values.iNTBFLFilePath == null) {
                  // logger.d(values.iNTBFLFileName);
                  // logger.d(values.iNTBFLFilePath);
                  Fluttertoast.showToast(msg: "No File to download");
                  return;
                }

                if (await canLaunchUrl(Uri.parse(values.iNTBFLFilePath!))) {
                  await launchUrl(Uri.parse(values.iNTBFLFilePath!),
                      mode: LaunchMode.externalApplication);
                } else {
                  Fluttertoast.showToast(
                      msg: "No External Application to handle this request");
                }
              },
              child: Container(
                margin: const EdgeInsets.only(right: 16.0),
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: const Color(0xFFD9EDFF)),
                child: SvgPicture.asset(
                  "assets/svg/download.svg",
                  height: 24.0,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
