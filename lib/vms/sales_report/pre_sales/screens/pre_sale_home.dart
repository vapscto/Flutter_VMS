import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/sales_report/pre_sales/api/pre_sales_api.dart';
import 'package:m_skool_flutter/vms/sales_report/pre_sales/controller/pre_sales_controller.dart';
import 'package:m_skool_flutter/vms/sales_report/pre_sales/widgets/completed_data_popup.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class PreSaleHomeScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const PreSaleHomeScreen(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<PreSaleHomeScreen> createState() => _PreSaleHomeScreenState();
}

class _PreSaleHomeScreenState extends State<PreSaleHomeScreen> {
  PreSalesController preSalesController = Get.put(PreSalesController());
  _getData() async {
    preSalesController.salesLoading(true);
    await PreSalesAPI.instance.preSalesList(
        base: baseUrlFromInsCode('recruitement', widget.mskoolController),
        userId: widget.loginSuccessModel.userId!,
        miId: widget.loginSuccessModel.mIID!,
        preSalesController: preSalesController);
    preSalesController.filterPreSaleList = preSalesController.preSaleList;
    preSalesController.salesLoading(false);
  }

  @override
  void initState() {
    _getData();
    preSalesController.filterPreSaleList = preSalesController.preSaleList;
    super.initState();
  }

  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchTextChanged(String text) {
    setState(() {
      preSalesController.filterPreSaleList.value = text.isEmpty
          ? _getData()
          : preSalesController.preSaleList
              .where((item) => item.ismslELeadName!
                      .toLowerCase()
                      .contains(text.toLowerCase())
                  //     ||
                  // item.ismsledMDemoType!
                  //     .toLowerCase()
                  //     .contains(text.toLowerCase()) ||
                  // item.ismsmsTStatusName!
                  //     .toLowerCase()
                  //     .contains(text.toLowerCase()) ||
                  // item.ismsledMContactPerson!
                  //     .toLowerCase()
                  //     .contains(text.toLowerCase())
                  )
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Pre Sales').getAppBar(),
      body: Obx(() {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 1),
              child: TextFormField(
                style: Get.textTheme.titleSmall!.copyWith(fontSize: 15),
                onChanged: (value) {
                  setState(() {
                    _onSearchTextChanged(value);
                  });
                },
                controller: _searchController,
                decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle: Get.textTheme.titleSmall!
                        .copyWith(color: Colors.grey, fontSize: 15),
                    suffixIcon: const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    )),
              ),
            ),
            (preSalesController.isPreSalesLoading.value)
                ? const Center(
                    child: AnimatedProgressWidget(
                        title: "Loading Pre Sales",
                        desc:
                            "Please wait while we load pre sales  and create a view for you.",
                        animationPath: "assets/json/default.json"),
                  )
                : (preSalesController.preSaleList.isEmpty)
                    ? const Center(
                        child: AnimatedProgressWidget(
                          animationPath: "assets/json/nodata.json",
                          animatorHeight: 250,
                          title: "No Pre Sales",
                          desc:
                              "We don't have any Pre Sales corresponding to the session",
                        ),
                      )
                    : Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.all(16),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: DataTable(
                                  headingRowColor: MaterialStatePropertyAll(
                                      Theme.of(context).primaryColor),
                                  dataTextStyle: const TextStyle(
                                      fontSize: 14,
                                      color: Color.fromRGBO(0, 0, 0, 0.95),
                                      fontWeight: FontWeight.w400),
                                  horizontalMargin: 10,
                                  headingTextStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                  border: TableBorder.all(
                                      borderRadius: BorderRadius.circular(10),
                                      width: 0.5),
                                  columns: const [
                                    DataColumn(
                                      label: Text('S.No'),
                                    ),
                                    DataColumn(
                                      label: Text("Lead Title"),
                                    ),
                                    DataColumn(
                                      label: Text('Demo Type'),
                                    ),
                                    DataColumn(
                                      label: Text('Health'),
                                    ),
                                    DataColumn(
                                      label: Text('Contact Person'),
                                    ),
                                    DataColumn(
                                      label: Text('Demo Date'),
                                    ),
                                    DataColumn(
                                      label: Text('Status'),
                                    ),
                                    DataColumn(
                                      label: Text('Action'),
                                    ),
                                  ],
                                  rows: List.generate(
                                      preSalesController
                                          .filterPreSaleList.length, (index) {
                                    var v = index + 1;
                                    var data = preSalesController
                                        .filterPreSaleList
                                        .elementAt(index);
                                    DateTime dt =
                                        DateTime.parse(data.ismsledMDemoDate!);
                                    var dmDate =
                                        "${dt.day}/${dt.month}/${dt.year}";
                                    return DataRow(cells: [
                                      DataCell(Text(v.toString())),
                                      DataCell(
                                          Text(data.ismslELeadName.toString())),
                                      DataCell(Text(
                                          data.ismsledMDemoType.toString())),
                                      DataCell(Text(
                                          data.ismsmsTStatusName.toString())),
                                      DataCell(Text(data.ismsledMContactPerson
                                          .toString())),
                                      DataCell(Text(dmDate.toString())),
                                      DataCell((data.ismsledMStatusFlg == 1)
                                          ? Text(
                                              "Completed",
                                              style: Get.textTheme.titleSmall!
                                                  .copyWith(
                                                      color: Colors.green),
                                            )
                                          : Text(
                                              "Open",
                                              style: Get.textTheme.titleSmall!
                                                  .copyWith(color: Colors.red),
                                            )),
                                      DataCell((data.ismsledMStatusFlg == 1)
                                          ? InkWell(
                                              onTap: () {
                                                Get.dialog(
                                                    CompletedDataPopUp(
                                                      preSalesController:
                                                          preSalesController,
                                                      loginSuccessModel: widget
                                                          .loginSuccessModel,
                                                      mskoolController: widget
                                                          .mskoolController,
                                                      hrmeId: 0,
                                                      hrmrId: 0,
                                                      ismsleId: data.ismslEId!,
                                                      ismsledmId:
                                                          data.ismsledMId!,
                                                    ),
                                                    barrierDismissible: false);
                                              },
                                              child: Icon(
                                                Icons.visibility,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            )
                                          : Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Get.dialog(
                                                        CompletedDataPopUp(
                                                          preSalesController:
                                                              preSalesController,
                                                          loginSuccessModel: widget
                                                              .loginSuccessModel,
                                                          mskoolController: widget
                                                              .mskoolController,
                                                          hrmeId: 0,
                                                          hrmrId: 0,
                                                          ismsleId:
                                                              data.ismslEId!,
                                                          ismsledmId:
                                                              data.ismsledMId!,
                                                        ),
                                                        barrierDismissible:
                                                            false);
                                                  },
                                                  child: Icon(
                                                    Icons.visibility,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.all(4.0),
                                                  child: VerticalDivider(
                                                    color: Colors.black,
                                                    thickness: 2,
                                                  ),
                                                ),
                                                InkWell(
                                                    onTap: () {},
                                                    child: Text(
                                                      "Demo Response",
                                                      style: Get.textTheme
                                                          .titleMedium!
                                                          .copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                    ))
                                              ],
                                            ))
                                    ]);
                                  })),
                            ),
                          ),
                        ),
                      ),
          ],
        );
      }),
    );
  }
}
