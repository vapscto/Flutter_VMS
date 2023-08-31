import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/notice/api/get_datewise_notices.dart';
import 'package:m_skool_flutter/notice/screen/notice_home.dart';
import 'package:m_skool_flutter/student/classwork/api/get_filtered_classwork.dart';
import 'package:m_skool_flutter/student/classwork/screen/classwork_home.dart';
import 'package:m_skool_flutter/student/homework/api/home_work_api.dart';
import 'package:m_skool_flutter/student/homework/screen/home_work.dart';
import 'package:m_skool_flutter/student/information/controller/hwcwnb_controller.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class InfoHome extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const InfoHome(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<InfoHome> createState() => _InfoHomeState();
}

class _InfoHomeState extends State<InfoHome> with TickerProviderStateMixin {
  TabController? tabController;
  final PageController pageController = PageController();
  final HwCwNbController hwCwNbController = Get.find<HwCwNbController>();
  List<Widget> pages = [];
  @override
  void initState() {
    pages.addAll([
      HomeWork(
        loginSuccessModel: widget.loginSuccessModel,
        mskoolController: widget.mskoolController,
        hwCwNbController: hwCwNbController,
      ),
      ClassworkHome(
        hwCwNbController: hwCwNbController,
        loginSuccessModel: widget.loginSuccessModel,
        mskoolController: widget.mskoolController,
      ),
      NoticeHome(
        loginSuccessModel: widget.loginSuccessModel,
        mskoolController: widget.mskoolController,
        hwCwNbController: hwCwNbController,
      ),
    ]);
    tabController = TabController(length: 3, vsync: this);
    // tabController!.addListener(() {
    //   pageController.animateToPage(tabController!.index,
    //       duration: const Duration(milliseconds: 800),
    //       curve: Curves.fastLinearToSlowEaseIn);
    // });
    // pageController.addListener(() {
    //   currentPage.value = tabController!.index;
    // });

    // tabController!.addListener(() {

    // });
    super.initState();
  }

  RxInt currentPage = RxInt(0);

  RxBool showFilter = RxBool(false);
  // DateTime startDate = DateTime.now();
  // DateTime endDate = DateTime.now();

  @override
  void dispose() {
    Get.delete<HwCwNbController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Info",
        action: [
          IconButton(
            onPressed: () {
              if (showFilter.value) {
                showFilter.value = false;
              } else {
                showFilter.value = true;
              }
              setState(() {});
            },
            icon: SvgPicture.asset('assets/svg/filter.svg'),
          ),
        ],
        // bottom: PreferredSize(
        //   preferredSize: Size.fromHeight(showFilter.value ? 130 : 0.0),
        //   child:
        // ),
      ).getAppBar(),
      body: Column(
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
                                    final DateTime? startDate =
                                        await showDatePicker(
                                            context: context,
                                            initialDate: hwCwNbController
                                                    .dtList.isNotEmpty
                                                ? hwCwNbController.dtList.first
                                                : DateTime.now(),
                                            firstDate: firstDate,
                                            lastDate: DateTime.now());
                                    if (startDate == null) {
                                      Fluttertoast.showToast(
                                          msg: "Please select start date");
                                      return;
                                    }
                                    hwCwNbController
                                        .updateStartDateProvided(true);
                                    if (hwCwNbController.dtList.isEmpty) {
                                      hwCwNbController.updateStartBy(
                                          "${startDate.year}-${startDate.month}-${startDate.day}");
                                      hwCwNbController.dtList.add(startDate);
                                    }

                                    if (hwCwNbController.dtList.length > 1) {
                                      hwCwNbController.dtList.first = startDate;
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
                                      borderRadius: BorderRadius.circular(12.0),
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
                                      "${endDate.year}-${endDate.month}-${endDate.day}");
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            width: double.infinity,
            color: Theme.of(context).primaryColor,
            child: Obx(() {
              return TabBar(
                  isScrollable: true,
                  controller: tabController,
                  unselectedLabelColor: Colors.white,
                  labelColor: Colors.black,
                  indicator: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                  ),
                  onTap: (e) {
                    currentPage.value = e;
                    pageController.animateToPage(e,
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.fastLinearToSlowEaseIn);
                  },
                  tabs: [
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          currentPage.value == 0
                              ? SvgPicture.asset(
                                  'assets/svg/hwcw.svg',
                                  color: Theme.of(context).iconTheme.color,
                                )
                              : const SizedBox(),
                          const SizedBox(
                            width: 6.0,
                          ),
                          Text(
                            "Homework",
                            style:
                                Theme.of(context).textTheme.titleSmall!.merge(
                                      TextStyle(
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.1,
                                          color: currentPage.value != 0
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                          ),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          currentPage.value == 1
                              ? SvgPicture.asset('assets/svg/classwork.svg')
                              : const SizedBox(),
                          const SizedBox(
                            width: 6.0,
                          ),
                          Text(
                            "Classwork",
                            style:
                                Theme.of(context).textTheme.titleSmall!.merge(
                                      TextStyle(
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.1,
                                          color: currentPage.value != 1
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                          ),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          currentPage.value == 2
                              ? SvgPicture.asset('assets/svg/notice.svg')
                              : const SizedBox(),
                          const SizedBox(
                            width: 6.0,
                          ),
                          Text(
                            "Noticeboard",
                            style:
                                Theme.of(context).textTheme.titleSmall!.merge(
                                      TextStyle(
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.1,
                                          color: currentPage.value != 2
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                          ),
                        ],
                      ),
                    )
                  ]);
            }),
          ),
          Flexible(
              child: SizedBox(
            height: Get.height,
            child: PageView.builder(
              controller: pageController,
              itemCount: pages.length,
              itemBuilder: (_, index) {
                return pages.elementAt(index);
              },
              onPageChanged: (v) {
                currentPage.value = v;
                tabController!.animateTo(v);
              },
            ),
          ))
        ],
      ),
    );
  }

  Future<void> filter() async {
    if (tabController!.index == 1) {
      await GetFilteredClasswork.instance.getFilteredClassWork(
        miId: widget.loginSuccessModel.mIID!,
        asmayId: widget.loginSuccessModel.asmaYId!,
        amstId: widget.loginSuccessModel.amsTId!,
        startDate: hwCwNbController.dtList.first.toLocal().toString(),
        endDate: hwCwNbController.dtList.last.toLocal().toString(),
        hwCwNbController: hwCwNbController,
        base: baseUrlFromInsCode(
          "portal",
          widget.mskoolController,
        ),
      );
      return;
    }

    if (tabController!.index == 2) {
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
      // await GetNoticeApi.instance.getNotice(
      //   miId: widget.loginSuccessModel.mIID!,
      //   asmayId:
      //       widget.loginSuccessModel.asmaYId!,
      //   amstId: widget.loginSuccessModel.amsTId!,
      //   startDate: hwCwNbController.dtList.first
      //       .toLocal()
      //       .toString(),
      //   endDate: hwCwNbController.dtList.last
      //       .toLocal()
      //       .toString(),
      //   controller: hwCwNbController,
      //   baseUrl: baseUrlFromInsCode(
      //     "portal",
      //     widget.mskoolController,
      //   ),
      // );
      return;
    }

    if (tabController!.index == 0) {
      await GetHomeWorkApi.instance.getHomeAssignment(
          miId: widget.loginSuccessModel.mIID!,
          asmayId: widget.loginSuccessModel.asmaYId!,
          amstId: widget.loginSuccessModel.amsTId!,
          startDate: hwCwNbController.dtList.first.toLocal().toString(),
          endDate: hwCwNbController.dtList.last.toLocal().toString(),
          baseUrl: baseUrlFromInsCode("portal", widget.mskoolController),
          hwCwNbController: hwCwNbController);
    }
  }
}
