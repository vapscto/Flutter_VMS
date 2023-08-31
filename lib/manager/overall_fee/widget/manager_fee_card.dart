import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/manager/overall_fee/screen/classwise_class_detail_screen.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class ManagerFeeCard extends StatefulWidget {
  final String title;
  final String classname;
  final num payable;
  final num totalCharges;
  final num totalPaid;
  final num concession;
  int? asmayId;
  int? asmclId;
  LoginSuccessModel? loginSuccessModel;
  MskoolController? mskoolController;

  ManagerFeeCard({
    super.key,
    required this.title,
    required this.classname,
    required this.concession,
    required this.payable,
    required this.totalCharges,
    required this.totalPaid,
    this.asmayId,
    this.asmclId,
    this.loginSuccessModel,
    this.mskoolController,
  });

  @override
  State<ManagerFeeCard> createState() => _ManagerFeeCardState();
}

class _ManagerFeeCardState extends State<ManagerFeeCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => ClasswiseClassDetailScreen(
              heading: widget.classname,
              loginSuccessModel: widget.loginSuccessModel!,
              mskoolController: widget.mskoolController!,
              asmayId: widget.asmayId!,
              asmclId: widget.asmclId!,
            ));
      },
      child: CustomContainer(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "${widget.title} : ",
                        style: Theme.of(context).textTheme.titleSmall!.merge(
                              const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Color.fromRGBO(0, 0, 0, 0.7),
                              ),
                            ),
                      ),
                      Text(
                        widget.classname,
                        style: Theme.of(context).textTheme.titleSmall!.merge(
                              const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                      )
                    ],
                  ),
                  Chip(
                      backgroundColor: const Color.fromRGBO(147, 255, 147, 1),
                      label: Text(
                        "Now Payable : ₹ ${widget.payable}",
                      )),
                ],
              ),
              const Divider(height: 5, thickness: 1),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Charges",
                    style: Theme.of(context).textTheme.titleSmall!.merge(
                          const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color.fromRGBO(0, 0, 0, 0.7),
                          ),
                        ),
                  ),
                  Text(
                    "₹${widget.totalCharges}",
                    style: Theme.of(context).textTheme.titleSmall!.merge(
                          const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Paid",
                    style: Theme.of(context).textTheme.titleSmall!.merge(
                          const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color.fromRGBO(0, 0, 0, 0.7),
                          ),
                        ),
                  ),
                  Text(
                    "₹${widget.totalPaid}",
                    style: Theme.of(context).textTheme.titleSmall!.merge(
                          const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Concession",
                    style: Theme.of(context).textTheme.titleSmall!.merge(
                          const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color.fromRGBO(0, 0, 0, 0.7),
                          ),
                        ),
                  ),
                  Text(
                    "₹${widget.concession}",
                    style: Theme.of(context).textTheme.titleSmall!.merge(
                          const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
