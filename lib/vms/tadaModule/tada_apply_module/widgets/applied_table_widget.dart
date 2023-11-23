import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/apis/tada_apply_edit_api.dart';
import 'package:m_skool_flutter/vms/tadaModule/tada_apply_module/controller/tada_apply_controller.dart';

class AppliedTableWidget extends StatelessWidget {
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccessModel;
  final TadaApplyDataController tadaApplyDataController;
  AppliedTableWidget({
    super.key,
    required this.tadaApplyDataController,
    required this.mskoolController,
    required this.loginSuccessModel,
  });
  var date = '';
  var time = '';
  var tosavedDate = '';
  var toSavedTime = '';
  var toSelectedDate = '';
  bool flag = false;

  @override
  Widget build(BuildContext context) {
    editData(int id) {
      tadaApplyDataController.editData(true);
      TadaEditAPI.instance.tadaApplyEditData(
          base: baseUrlFromInsCode('issuemanager', mskoolController),
          userId: loginSuccessModel.userId!,
          miId: loginSuccessModel.mIID!,
          vtadaaaId: id,
          tadaApplyController: tadaApplyDataController);
      tadaApplyDataController.editData(false);
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: DataTable(
          dataRowHeight: 35,
          headingRowHeight: 45,
          columnSpacing: 20,
          headingTextStyle: const TextStyle(color: Colors.white),
          border: TableBorder.all(
            color: Colors.black,
            width: 0.6,
            borderRadius: BorderRadius.circular(10),
          ),
          headingRowColor: MaterialStateColor.resolveWith(
              (states) => Theme.of(context).primaryColor),
          columns: const [
            DataColumn(label: Text("SL.NO.")),
            DataColumn(label: Text("City")),
            DataColumn(label: Text("Form Date")),
            DataColumn(label: Text("Departure Time")),
            DataColumn(label: Text("To Date")),
            DataColumn(label: Text("Arrival Time")),
            DataColumn(label: Text("Total Applied Amount")),
            DataColumn(label: Text("Action")),
          ],
          rows: List.generate(tadaApplyDataController.getSavedData.length,
              (index) {
            var value = index + 1;
            if (tadaApplyDataController.getSavedData[index].vtadaAFromDate !=
                null) {
              DateTime dt = DateTime.parse(
                  tadaApplyDataController.getSavedData[index].vtadaAFromDate!);
              date = '${dt.day}-${dt.month}-${dt.year}';
            }
            if (tadaApplyDataController.getSavedData[index].vtadaAToDate !=
                null) {
              DateTime dt = DateTime.parse(
                  tadaApplyDataController.getSavedData[index].vtadaAToDate!);
              toSelectedDate = '${dt.day}-${dt.month}-${dt.year}';
            }
            if (tadaApplyDataController
                    .getSavedData[index].vtadaADepartureTime !=
                null) {
              TimeOfDay startTime = TimeOfDay(
                  hour: int.parse(tadaApplyDataController
                      .getSavedData[index].vtadaADepartureTime!
                      .split(":")[0]),
                  minute: int.parse(tadaApplyDataController
                      .getSavedData[index].vtadaADepartureTime!
                      .split(":")[1]));
              time =
                  '${startTime.hourOfPeriod}:${startTime.minute} ${startTime.period.name.toUpperCase()}';
            }

            //
            if (tadaApplyDataController.getSavedData[index].vtadaAArrivalTime !=
                null) {
              TimeOfDay startToTime = TimeOfDay(
                  hour: int.parse(tadaApplyDataController
                      .getSavedData[index].vtadaAArrivalTime!
                      .split(":")[0]),
                  minute: int.parse(tadaApplyDataController
                      .getSavedData[index].vtadaAArrivalTime!
                      .split(":")[1]));
              toSavedTime =
                  '${startToTime.hourOfPeriod}:${startToTime.minute} ${startToTime.period.name.toUpperCase()}';
            }

            return DataRow(cells: [
              DataCell(Text(value.toString())),
              DataCell(Text(
                  tadaApplyDataController.getSavedData[index].ivrmmcTName ??
                      "")),
              DataCell(Text(date)),
              DataCell(Text(time)),
              DataCell(Text(toSelectedDate)),
              DataCell(Text(toSavedTime)),
              DataCell(Text(tadaApplyDataController
                  .getSavedData[index].vtadaATotalAppliedAmount
                  .toString())),
              DataCell(InkWell(
                  onTap: () {
                    // if (tadaApplyDataController.isDocumentUpload.value == true) {
                    //   Fluttertoast.showToast(
                    //       msg: "Previous TA-DA Adavance Is Pending,");
                    // } else {
                    editData(
                        tadaApplyDataController.getSavedData[index].vtadaAId!);
                    // }
                  },
                  child: (tadaApplyDataController.getSavedData
                              .elementAt(index)
                              .vtadaAActiveFlg! ==
                          true)
                      ? Row(
                          children: [
                            Text(
                              "Deactivate",
                              style: Get.textTheme.titleMedium!.copyWith(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w200,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        )
                      : Text(
                          "Activate",
                          style: Get.textTheme.titleMedium!.copyWith(
                              color: Colors.green,
                              fontWeight: FontWeight.w200,
                              fontStyle: FontStyle.italic),
                        ))),
            ]);
          }),
        ),
      ),
    );
  }
}
