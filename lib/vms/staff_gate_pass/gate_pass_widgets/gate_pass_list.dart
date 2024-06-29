import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/staff_gate_pass/gate_pass_api/gate_pass_api.dart';
import 'package:m_skool_flutter/vms/staff_gate_pass/gate_pass_controller/gate_pass_controller.dart';
import 'package:m_skool_flutter/vms/staff_gate_pass/gate_pass_model/pass_inst_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';

class GatePassListScreen extends StatefulWidget {
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccessModel;
  final GatePassController controller;
  const GatePassListScreen(
      {super.key,
      required this.mskoolController,
      required this.loginSuccessModel,
      required this.controller});

  @override
  State<GatePassListScreen> createState() => _GatePassListScreenState();
}

class _GatePassListScreenState extends State<GatePassListScreen> {
  RxBool isLoading = RxBool(false);
  final _suggestionsBoxController1 = SuggestionsBoxController();
  final miName = TextEditingController();
  int miId = 0;
  _onLoad(int id) async {
    isLoading.value = true;
    await GatePassAPI.instance.onLoad(
        base: baseUrlFromInsCode(
            'visitorsmanagementservicehub', widget.mskoolController),
        miId: id,
        userId: widget.loginSuccessModel.userId!,
        controller: widget.controller);
    isLoading.value = false;
    miName.text = widget.controller.institutionList.first.mIName ?? "";
    miId = widget.controller.institutionList.first.mIId ?? 0;
  }

  @override
  void initState() {
    _onLoad(miId);
    super.initState();
  }

  @override
  void dispose() {
    miId = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return isLoading.value
          ? const Center(
              child: AnimatedProgressWidget(
                animationPath: 'assets/json/default.json',
                title: 'Loading data',
                desc: "Please wait we are loading data",
              ),
            )
          : (widget.controller.institutionList.isEmpty)
              ? const Center(
                  child: AnimatedProgressWidget(
                    animationPath: 'assets/json/nodata.json',
                    title: 'No data',
                    desc: "",
                  ),
                )
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    TypeAheadFormField<GatePassInstModelValues>(
                      suggestionsBoxController: _suggestionsBoxController1,
                      getImmediateSuggestions: true,
                      textFieldConfiguration: TextFieldConfiguration(
                        style: Get.textTheme.titleSmall,
                        controller: miName,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            hintStyle: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: Colors.grey, fontSize: 14),
                            hintText:
                                widget.controller.institutionList.isNotEmpty
                                    ? 'Company Name'
                                    : 'No data available',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: 'Company Name',
                            labelStyle: Get.textTheme.titleSmall!
                                .copyWith(fontSize: 18),
                            suffixIcon: (miName.text.isEmpty)
                                ? const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.black,
                                    size: 30,
                                  )
                                : IconButton(
                                    onPressed: () async {
                                      miName.clear();
                                      miId = 0;
                                      await GatePassAPI.instance.onLoad(
                                          base: baseUrlFromInsCode(
                                              'visitorsmanagementservicehub',
                                              widget.mskoolController),
                                          miId: miId,
                                          userId:
                                              widget.loginSuccessModel.userId!,
                                          controller: widget.controller);
                                      setState(() {});
                                    },
                                    icon: const Icon(Icons.clear_outlined))),
                      ),
                      suggestionsCallback: (v) {
                        return widget.controller.institutionList.where((d) =>
                            d.mIName!.toLowerCase().contains(v.toLowerCase()));
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          onTap: () async {
                            miName.text = suggestion.mIName!;
                            miId = suggestion.mIId!;
                            _suggestionsBoxController1.close();
                            setState(() {
                              isDataLoading.value = true;
                            });
                            await GatePassAPI.instance.onLoad(
                                base: baseUrlFromInsCode(
                                    'visitorsmanagementservicehub',
                                    widget.mskoolController),
                                miId: miId,
                                userId: widget.loginSuccessModel.userId!,
                                controller: widget.controller);
                            setState(() {
                              isDataLoading.value = false;
                            });
                          },
                          title: Text(
                            suggestion.mIName!,
                            style: Get.textTheme.titleSmall,
                          ),
                        );
                      },
                      onSuggestionSelected: (suggestion) {},
                      noItemsFoundBuilder: (context) {
                        return const SizedBox();
                      },
                    ),
                    const SizedBox(height: 10),
                    (isDataLoading.value)
                        ? const Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.red,
                              color: Colors.green,
                              strokeWidth: 6,
                            ),
                          )
                        : (widget.controller.gatePassedList.isEmpty)
                            ? const SizedBox()
                            : SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: DataTable(
                                    headingRowColor: MaterialStatePropertyAll(
                                        Theme.of(context).primaryColor),
                                    dataTextStyle: const TextStyle(
                                        fontSize: 14,
                                        color: Color.fromRGBO(0, 0, 0, 0.95),
                                        fontWeight: FontWeight.w400),
                                    headingRowHeight: 45,
                                    dataRowHeight: 45,
                                    dividerThickness: 1,
                                    horizontalMargin: 10,
                                    headingTextStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700),
                                    border: TableBorder.all(
                                        borderRadius: BorderRadius.circular(10),
                                        width: 0.5),
                                    columns: const [
                                      DataColumn(
                                        label: Text('S.No'),
                                      ),
                                      DataColumn(
                                        label: Text("Staff Name"),
                                      ),
                                      DataColumn(
                                        label: Text('Department'),
                                      ),
                                      DataColumn(
                                        label: Text('Designation'),
                                      ),
                                      DataColumn(
                                        label: Text('Gate Pass No'),
                                      ),
                                      DataColumn(
                                        label: Text('Card No'),
                                      ),
                                      DataColumn(
                                        label: Text('Date'),
                                      ),
                                      DataColumn(
                                        label: Text('Remarks'),
                                      ),
                                      DataColumn(
                                        label: Align(
                                            alignment: Alignment.center,
                                            child: Text('Action')),
                                      ),
                                    ],
                                    rows: List.generate(
                                        widget.controller.gatePassedList.length,
                                        (index) {
                                      var i = index + 1;
                                      var d = widget.controller.gatePassedList
                                          .elementAt(index);
                                      return DataRow(cells: [
                                        DataCell(Text(i.toString())),
                                        DataCell(Text(d.empname ?? "")),
                                        DataCell(
                                            Text(d.hrmDDepartmentName ?? "")),
                                        DataCell(Text(
                                            d.hrmdeSDesignationName ?? "")),
                                        const DataCell(Text("")),
                                        DataCell(Text(d.gphsTIDCardNo ?? "")),
                                        DataCell(Text(dateFormat1(
                                            DateTime.parse(d.gphsTDateTime!)))),
                                        DataCell(Text(d.gphsTRemarks ?? "")),
                                        DataCell(Row(
                                          children: [
                                            // IconButton(
                                            //     onPressed: () {
                                            //       logger.w(d.toJson());
                                            //     },
                                            //     icon: const Icon(Icons.edit)),
                                            TextButton(
                                                onPressed: () async {
                                                  await GatePassAPI.instance.activate(
                                                      base: baseUrlFromInsCode(
                                                          'visitorsmanagementservicehub',
                                                          widget
                                                              .mskoolController),
                                                      body: {
                                                        "GPHST_Id": d.gphsTId,
                                                        "MI_Id": d.mIId,
                                                        "HRME_Id": d.hrmEId,
                                                        "GPHST_DateTime":
                                                            d.gphsTDateTime,
                                                        "UserId": widget
                                                            .loginSuccessModel
                                                            .userId,
                                                        "empname": d.empname,
                                                        "HRMD_Id": d.hrmDId,
                                                        "HRMDES_Id": d.hrmdeSId,
                                                        "HRMD_DepartmentName": d
                                                            .hrmDDepartmentName,
                                                        "HRMDES_DesignationName":
                                                            d.hrmdeSDesignationName
                                                      }).then((value) async {
                                                    if (value == 200) {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "Record Updated Successfully");
                                                      await GatePassAPI.instance.onLoad(
                                                          base: baseUrlFromInsCode(
                                                              'visitorsmanagementservicehub',
                                                              widget
                                                                  .mskoolController),
                                                          miId: miId,
                                                          userId: widget
                                                              .loginSuccessModel
                                                              .userId!,
                                                          controller: widget
                                                              .controller);
                                                    }
                                                  });
                                                },
                                                child: (d.gphsTActiveFlg ==
                                                        true)
                                                    ? Text(
                                                        "De-Activate",
                                                        style: Get.textTheme
                                                            .titleSmall!
                                                            .copyWith(
                                                                color:
                                                                    Colors.red,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      )
                                                    : Text(
                                                        "Activate",
                                                        style: Get.textTheme
                                                            .titleSmall!
                                                            .copyWith(
                                                                color: Colors
                                                                    .green,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      )),
                                          ],
                                        ))
                                      ]);
                                    }),
                                  ),
                                ),
                              )
                  ],
                );
    });
  }

  RxBool isDataLoading = RxBool(false);
}
