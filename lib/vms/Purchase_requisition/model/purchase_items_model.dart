import 'package:flutter/material.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class PurchaseItemModel extends StatefulWidget {
  const PurchaseItemModel({super.key});

  @override
  State<PurchaseItemModel> createState() => _PurchaseItemModelState();
}

class _PurchaseItemModelState extends State<PurchaseItemModel> {
  final uomController = TextEditingController();
  final quantityController = TextEditingController();
  final rateController = TextEditingController();
  final amountController = TextEditingController();
  final remarksController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:       Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomContainer(
                          child: TextField(
                            style: Theme.of(context).textTheme.titleSmall,
                            controller: uomController,
                            readOnly: true,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              label: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 6.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24.0),
                                    color: const Color.fromARGB(255, 224, 53, 6)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      "assets/images/subjectfielicon.png",
                                      height: 24.0,
                                      color: const Color.fromARGB(167, 38, 24, 238),
                                    ),
                                    const SizedBox(
                                      width: 6.0,
                                    ),
                                    Text(
                                      " UOM ",
                                      style:
                                          Theme.of(context).textTheme.labelMedium!.merge(
                                                const TextStyle(
                                                    fontSize: 20.0,
                                                    color: Color.fromARGB(255, 247, 251, 252)),
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
                        const SizedBox(height: 30),
                         CustomContainer(
                          child: TextField(
                            style: Theme.of(context).textTheme.titleSmall,
                            controller: quantityController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              label: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 6.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24.0),
                                  color: const Color.fromARGB(255, 199, 251, 12)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      "assets/images/subjectfielicon.png",
                                      height: 24.0,
                                      color: const Color.fromARGB(167, 21, 1, 1),
                                    ),
                                    const SizedBox(
                                      width: 6.0,
                                    ),
                                    Text(
                                      " Quantity ",
                                      style:
                                          Theme.of(context).textTheme.labelMedium!.merge(
                                                const TextStyle(
                                                    fontSize: 20.0,
                                                    color: Color.fromARGB(255, 11, 41, 234)),
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
                        const SizedBox(height: 30),
                         CustomContainer(
                          child: TextField(
                            style: Theme.of(context).textTheme.titleSmall,
                            controller: rateController,
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              int rate = int.parse(rateController.text) ;
                              setState(() {
                                int amount =  rate * int.parse(quantityController.text);
                                amountController.text = amount.toString();
                              });
                            },
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              label: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 6.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24.0),
                                   color: const Color.fromARGB(255, 246, 240, 240)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      "assets/images/subjectfielicon.png",
                                      height: 24.0,
                                      color: const Color.fromARGB(255, 12, 14, 0),
                                    ),
                                    const SizedBox(
                                      width: 6.0,
                                    ),
                                    Text(
                                      " Approximate Rate ",
                                      style:
                                          Theme.of(context).textTheme.labelMedium!.merge(
                                                const TextStyle(
                                                    fontSize: 20.0,
                                                    color: Color.fromARGB(255, 58, 4, 219)),
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
                        const SizedBox(height: 30),
                         CustomContainer(
                          child: TextField(
                            style: Theme.of(context).textTheme.titleSmall,
                            controller: amountController,
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                            // value =  rateController.text * int.parse(quantityController.text);
                            },
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              label: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 6.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24.0),
                                    color: const Color.fromARGB(255, 6, 24, 89)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      "assets/images/subjectfielicon.png",
                                      height: 24.0,
                                       color: const Color.fromARGB(255, 249, 254, 253),
                                    ),
                                    const SizedBox(
                                      width: 6.0,
                                    ),
                                    Text(
                                      " Approximent Amount ",
                                      style:
                                          Theme.of(context).textTheme.labelMedium!.merge(
                                                const TextStyle(
                                                    fontSize: 20.0,
                                                    color: Color.fromARGB(255, 191, 234, 4)),
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
                        const SizedBox(height: 30),
                         CustomContainer(
                          child: TextField(
                            style: Theme.of(context).textTheme.titleSmall,
                            controller: remarksController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              label: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 6.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24.0),
                                    color: const Color.fromARGB(255, 11, 1, 0)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      "assets/images/subjectfielicon.png",
                                      height: 24.0,
                                    ),
                                    const SizedBox(
                                      width: 6.0,
                                    ),
                                    Text(
                                      " Remarks ",
                                      style:
                                          Theme.of(context).textTheme.labelMedium!.merge(
                                                const TextStyle(
                                                    fontSize: 20.0,
                                                    color: Color.fromARGB(255, 250, 251, 251)),
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
                      ],
                    ),
                  ),
    );
  }
}