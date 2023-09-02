import 'package:flutter/material.dart';

class TableDataModel2 {
  String city;
  String days;
  String fromDate;
  String departureTime;
  String toDate;
  String arrivalTime;
  IconButton onClick;
  TableDataModel2(this.city, this.days, this.fromDate, this.departureTime,
      this.toDate, this.arrivalTime, this.onClick);
}
