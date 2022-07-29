import 'package:users/models/models.dart';

class Saloon {
  String? id;
  String? name;
  String? address;
  String? openTime;
  String? closeTime;

  Saloon({this.id, this.name, this.address, this.openTime, this.closeTime});

  factory Saloon.fromMap(Map map) {
    return Saloon(
      id: map['id'],
      name: map['name'],
      address: map['address'],
      openTime: map['openTime'],
      closeTime: map['closeTime'],
    );
  }
}

class Day {
  String? date;
  String? saloonID;
  List<TimeSlot>? timeSlotsList = [];
  Day({this.date, this.saloonID, this.timeSlotsList});
  factory Day.fromMap(Map map) {
    return Day(
      date: map['date'],
      saloonID: map['saloonID'],
      timeSlotsList: (map['timeSlotsList'] as List)
          .map((e) => TimeSlot.fromMap(e))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': '$date',
      'saloonID': '$saloonID',
      'timeSlotsList': timeSlotsList!.map((e) => e).toString(),
    };
  }
}

class TimeSlot {
  String? startTime;
  String? endTime;
  String? status; // Open/Filled/Blocked
  List<SlotDetails>? timeSlotsDetails = [];

  TimeSlot({this.startTime, this.endTime, this.status, this.timeSlotsDetails});
  factory TimeSlot.fromMap(Map map) {
    return TimeSlot(
      startTime: map['date'],
      endTime: map['saloonID'],
      timeSlotsDetails: (map['timeSlotsDetails'] as List)
          .map((e) => SlotDetails.fromMap(e))
          .toList(),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'startTime': '$startTime',
      'endTime': '$endTime',
      'status': '$status',
      'timeSlotsDetails': timeSlotsDetails!.map((e) => e).toString(),
    };
  }
}

class SlotDetails {
  String? customerName;
  String? customerPhone;
  String? customerEmail;
  String? service;
  SlotDetails(
      {this.customerName,
      this.customerPhone,
      this.customerEmail,
      this.service});
  factory SlotDetails.fromMap(Map map) {
    return SlotDetails(
      customerName: map['customerName'],
      customerPhone: map['customerPhone'],
      customerEmail: map['customerEmail'],
      service: map['service'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'customerName': '$customerName',
      'customerPhone': '$customerPhone',
      'customerEmail': '$customerEmail',
      'service': '$service',
    };
  }
}
