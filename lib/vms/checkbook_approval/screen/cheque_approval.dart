import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/marks_entry/widget/dropdown_label.dart';
import 'package:m_skool_flutter/vms/checkbook_approval/api/fetchCompaniesList.dart';
import 'package:m_skool_flutter/vms/checkbook_approval/api/updateCheck.dart';
import 'package:m_skool_flutter/vms/checkbook_approval/controller/cheque_controller.dart';
import 'package:m_skool_flutter/vms/checkbook_approval/controller/detailed_todo_controller.dart';
import 'package:m_skool_flutter/vms/checkbook_approval/model/company_model.dart';
import 'package:m_skool_flutter/vms/checkbook_approval/widget/detail_table.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/custom_back_btn.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class ChequeApproval extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const ChequeApproval(
      {required this.loginSuccessModel,
      required this.mskoolController,
      super.key});

  @override
  State<ChequeApproval> createState() => _ChequeApprovalState();
}

class _ChequeApprovalState extends State<ChequeApproval> {
  final ChequeController _chequeController = Get.put(ChequeController());
  final GetDetailedToDo _controller = Get.put(GetDetailedToDo());
  int? mid;
  @override
  void initState() {
    super.initState();
    load();
  }

  load() async {
    await getCompaniesList(base: "", controller: _chequeController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: const CustomGoBackButton(),
        title: const Text(
          "Cheque Approval",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
        ),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: Column(children: [
          Obx(
            () => _chequeController.isErrorOccuredWhileLoading.value
                ? const Center(
                    child: ErrWidget(
                      err: {
                        "errorTitle": "Unexpected Error Occured",
                        "errorMsg":
                            "While loading company we encountered an error"
                      },
                    ),
                  )
                : _chequeController.isLoading.value
                    ? const AnimatedProgressWidget(
                        animationPath: 'assets/json/default.json',
                        title: 'Loading data',
                        desc: "Please wait we are loading data",
                      )
                    : Container(
                        margin: const EdgeInsets.only(
                            top: 40, left: 16, right: 16, bottom: 16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 1),
                              blurRadius: 8,
                              color: Colors.black12,
                            ),
                          ],
                        ),
                        child: DropdownButtonFormField<CompanyListValues>(
                          value: _chequeController.companiesList.first,
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
                            hintStyle: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .merge(const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.0,
                                    letterSpacing: 0.3)),
                            hintText: _chequeController.companiesList.isNotEmpty
                                ? 'Select Organization'
                                : 'No data available',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            isDense: true,
                            label: const CustomDropDownLabel(
                              icon: 'assets/images/hat.png',
                              containerColor: Color.fromRGBO(223, 251, 254, 1),
                              text: 'Organization',
                              textColor: Color.fromRGBO(40, 182, 200, 1),
                            ),
                          ),
                          icon: const Padding(
                            padding: EdgeInsets.only(top: 3),
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 30,
                            ),
                          ),
                          iconSize: 30,
                          items: List.generate(
                              _chequeController.companiesList.length, (index) {
                            return DropdownMenuItem(
                              value: _chequeController.companiesList[index],
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 13, left: 5),
                                child: Text(
                                  overflow: TextOverflow.clip,
                                  _chequeController
                                      .companiesList[index].mIName!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .merge(const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.0,
                                          letterSpacing: 0.3)),
                                ),
                              ),
                            );
                          }),
                          onChanged: (s) async {
                            _controller.getTaDaModelList.clear();
                            _controller.radioSelect.clear();
                            _controller.tEControllerListOfSncAmount.clear();
                            _controller.tEControllerListOfNarration.clear();
                            _controller.tEControllerListOfApprovalRemark
                                .clear();
                            _controller.checkList.clear();
                            mid = s!.mIId;
                            await updateCheque(
                                userId: 60064,
                                mi_id: s.mIId!,
                                controller: _controller);
                          },
                        ),
                      ),
          ),
          Obx(() => _controller.isLoading.isTrue
              ? const AnimatedProgressWidget(
                  animationPath: 'assets/json/default.json',
                  title: 'Loading data',
                  desc: "Please wait we are loading data",
                )
              : _controller.getTaDaModelList.isNotEmpty
                  ? GetTaDa(
                      loginSuccessModel: widget.loginSuccessModel,
                      mskoolController: widget.mskoolController,
                      controller: _controller,
                      mi_id: mid!,
                    )
                  : const Center(
                      child: AnimatedProgressWidget(
                        animationPath: 'assets/json/nodata.json',
                        title: 'No Details found',
                        desc: "For this company has no data to show",
                        animatorHeight: 250,
                      ),
                    ))
        ]),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
