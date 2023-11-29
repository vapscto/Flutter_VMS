import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/sales_report/pre_sales/api/pre_sales_view_api.dart';
import 'package:m_skool_flutter/vms/sales_report/pre_sales/controller/pre_sales_controller.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class CompletedDataPopUp extends StatefulWidget {
  final PreSalesController preSalesController;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final int ismsledmId;
  final int hrmrId;
  final int ismsleId;
  final int hrmeId;
  const CompletedDataPopUp(
      {super.key,
      required this.preSalesController,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.ismsledmId,
      required this.hrmrId,
      required this.ismsleId,
      required this.hrmeId});

  @override
  State<CompletedDataPopUp> createState() => _CompletedDataPopUpState();
}

class _CompletedDataPopUpState extends State<CompletedDataPopUp> {
  _getData() async {
    widget.preSalesController.productLoading(true);
    await PreSalesViewAPI.instance.preSalesView(
        base: '',
        userId: widget.loginSuccessModel.userId!,
        miId: widget.loginSuccessModel.mIID!,
        ismsledmId: widget.ismsledmId,
        hrmrId: widget.hrmrId,
        ismsleId: widget.ismsleId,
        hrmeId: 0,
        preSalesController: widget.preSalesController);
    await PreSalesViewAPI.instance.preSalesViewResponse(
        base: '',
        userId: widget.loginSuccessModel.userId!,
        miId: widget.loginSuccessModel.mIID!,
        ismsledmId: widget.ismsledmId,
        hrmrId: widget.hrmrId,
        ismsleId: widget.ismsleId,
        hrmeId: 0,
        viewAll: 1,
        preSalesController: widget.preSalesController);
    widget.preSalesController.productLoading(false);
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: Colors.white)),
        contentPadding: const EdgeInsets.all(10),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Sales Lead Demo",
                    style: Get.textTheme.titleMedium!
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                ),
                const SizedBox(height: 8),
                (widget.preSalesController.viewLeadModel.isEmpty)
                    ? const SizedBox()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Lead Title: ',
                                    style: Get.textTheme.titleSmall!.copyWith(
                                        color: Theme.of(context).primaryColor)),
                                TextSpan(
                                    text: widget.preSalesController
                                        .viewLeadModel.first.ismslELeadName,
                                    style: Get.textTheme.titleSmall),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Address: ',
                                    style: Get.textTheme.titleSmall!.copyWith(
                                        color: Theme.of(context).primaryColor)),
                                TextSpan(
                                    text: widget
                                        .preSalesController
                                        .viewLeadModel
                                        .first
                                        .ismsledMDemoAddress,
                                    style: Get.textTheme.titleSmall),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Contact Persion: ',
                                    style: Get.textTheme.titleSmall!.copyWith(
                                        color: Theme.of(context).primaryColor)),
                                TextSpan(
                                    text: widget
                                        .preSalesController
                                        .viewLeadModel
                                        .first
                                        .ismsledMContactPerson,
                                    style: Get.textTheme.titleSmall),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Remarks: ',
                                    style: Get.textTheme.titleSmall!.copyWith(
                                        color: Theme.of(context).primaryColor)),
                                TextSpan(
                                    text: widget.preSalesController
                                        .viewLeadModel.first.ismsledMRemarks,
                                    style: Get.textTheme.titleSmall),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                (widget.preSalesController.isProdustDataLoading.value)
                    ? const Center(
                        child: AnimatedProgressWidget(
                            title: "Loading",
                            desc: " ",
                            animationPath: "assets/json/default.json"),
                      )
                    : (widget.preSalesController.productListData.isEmpty)
                        ? const Center(
                            child: AnimatedProgressWidget(
                              animationPath: "assets/json/nodata.json",
                              animatorHeight: 250,
                              title: "No Product List",
                              desc:
                                  "We don't have any Pre Sales corresponding to the session",
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Product Details",
                                style: Get.textTheme.titleMedium!.copyWith(
                                    color: Theme.of(context).primaryColor),
                              ),
                              const SizedBox(height: 8),
                              _getProductTable(),
                            ],
                          ),
                (widget.preSalesController.demoResponseList.isEmpty)
                    ? const SizedBox()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          Text(
                            "Response Details",
                            style: Get.textTheme.titleMedium!.copyWith(
                                color: Theme.of(context).primaryColor),
                          ),
                          const SizedBox(height: 8),
                          _getResponseTable(),
                        ],
                      ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: MSkollBtn(
                      title: "Back",
                      onPress: () {
                        Get.back();
                      }),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  _getProductTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: DataTable(
          headingRowHeight: 37,
          dataRowHeight: 37,
          headingRowColor:
              MaterialStatePropertyAll(Theme.of(context).primaryColor),
          dataTextStyle: const TextStyle(
              fontSize: 14,
              color: Color.fromRGBO(0, 0, 0, 0.95),
              fontWeight: FontWeight.w400),
          horizontalMargin: 10,
          headingTextStyle:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          border: TableBorder.all(
              borderRadius: BorderRadius.circular(10), width: 0.5),
          columns: const [
            DataColumn(
              label: Text('S.No'),
            ),
            DataColumn(
              label: Text("Product Name"),
            ),
            DataColumn(
              label: Text('Discussion Points'),
            ),
          ],
          rows: List.generate(widget.preSalesController.productListData.length,
              (index) {
            var data =
                widget.preSalesController.productListData.elementAt(index);
            var v = index + 1;
            return DataRow(cells: [
              DataCell(Text(v.toString())),
              DataCell(Text(data.ismsmpRProductName.toString())),
              DataCell(Text(data.ismsledmpRDiscussionPoints.toString())),
            ]);
          }),
        ),
      ),
    );
  }

  _getResponseTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: DataTable(
          headingRowHeight: 37,
          dataRowHeight: 37,
          headingRowColor:
              MaterialStatePropertyAll(Theme.of(context).primaryColor),
          dataTextStyle: const TextStyle(
              fontSize: 14,
              color: Color.fromRGBO(0, 0, 0, 0.95),
              fontWeight: FontWeight.w400),
          horizontalMargin: 10,
          headingTextStyle:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          border: TableBorder.all(
              borderRadius: BorderRadius.circular(10), width: 0.5),
          columns: const [
            DataColumn(
              label: Text('S.No'),
            ),
            DataColumn(
              label: Text("Product Name"),
            ),
            DataColumn(
              label: Text('Discussion Points'),
            ),
            DataColumn(
              label: Text('Status Name'),
            ),
            DataColumn(
              label: Text('Remarks'),
            ),
          ],
          rows: List.generate(widget.preSalesController.demoResponseList.length,
              (index) {
            var response =
                widget.preSalesController.demoResponseList.elementAt(index);
            var v = index + 1;
            return DataRow(cells: [
              DataCell(Text(v.toString())),
              DataCell(Text(response.ismsmpRProductName.toString())),
              DataCell(Text(response.ismsledmpRDiscussionPoints.toString())),
              DataCell(Text(response.ismsmsTStatusName.toString())),
              DataCell(Text(response.ismsledmpRRemarks ?? '')),
            ]);
          }),
        ),
      ),
    );
  }
}
