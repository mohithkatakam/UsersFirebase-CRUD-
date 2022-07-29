import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:time_range/time_range.dart';
import 'package:date_time_picker_widget/date_time_picker_widget.dart';
import 'package:users/booking_slots.dart';
import 'package:users/models/models.dart';
import 'package:users/profile.dart';

class BookingSlots extends StatefulWidget {
  const BookingSlots({Key? key}) : super(key: key);

  @override
  State<BookingSlots> createState() => _BookingSlotsState();
}

String? selectedChip;

class ChoiceChipWidget extends StatefulWidget {
  final String chipName;
  const ChoiceChipWidget({Key? key, required this.chipName}) : super(key: key);

  @override
  _ChoiceChipWidgetState createState() => _ChoiceChipWidgetState();
}

CollectionReference users = FirebaseFirestore.instance.collection('users');

Future<void> addUser() {
  // Call the user's CollectionReference to add a new user

  return users
      .add({
    'userName': "Anil", // John Doe
    'phoneNumber': "123456789", // Stokes and Sons
    'location': "HYD" ,
    'emailId':"anil@tridemobility.com"// 42
  }).then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}

class _ChoiceChipWidgetState extends State<ChoiceChipWidget> {
  var isChipSelected = false;
  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(widget.chipName),
      selected: isChipSelected,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      backgroundColor: Colors.white24,
      onSelected: (isSelected) {
        selectedChip = widget.chipName;
        setState(() {
          isChipSelected = isSelected;
        });
      },
      selectedColor: Colors.blue,
      disabledColor: Colors.grey,
    );
  }
}

class _BookingSlotsState extends State<BookingSlots> {
  // static const orange = Color(0xFFFE9A75);
  // static const dark = Color(0xFF333A47);
  // static const double leftPadding = 50;

  DatePickerController _controller = DatePickerController();
  DateTime selectedDate = DateTime.now();

  // final _defaultTimeRange = TimeRangeResult(
  //   TimeOfDay(hour: 9, minute: 00),
  //   TimeOfDay(hour: 19, minute: 00),
  // );
  // TimeRangeResult? _timeRange;
  @override
  void initState() {
    super.initState();
    //_timeRange = _defaultTimeRange;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Time Slot"),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Myprofile()));
          },
          icon: Icon(Icons.accessibility),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => BookedSlots()));
        },
        label: Text("Bookings"),
      ),
      body: Container(
        child: Column(children: [
          Container(
              child: Card(
                  child: DatePicker(
            DateTime.now(),
            width: 60,
            height: 80,
            controller: _controller,
            initialSelectedDate: DateTime.now(),
            selectionColor: Colors.blue,
            selectedTextColor: Colors.white,
            // inactiveDates: [
            //   DateTime.now().add(Duration(days: 3)),
            //   DateTime.now().add(Duration(days: 4)),
            //   DateTime.now().add(Duration(days: 7))
            // ],
            onDateChange: (date) {
              // New date selected
              setState(() {
                selectedDate = date;
              });
            },
          ))),
          Container(
              margin: EdgeInsets.all(10),
              height: 200,
              child: ListView(
                children: [
                  Wrap(
                    spacing: 5,
                    runSpacing: 3,
                    children: const [
                      ChoiceChipWidget(chipName: "9:00AM - 10:00AM"),
                      ChoiceChipWidget(chipName: "10:00AM - 11:00AM"),
                      ChoiceChipWidget(chipName: "11:00AM - 12:00PM"),
                      ChoiceChipWidget(chipName: "12:00 PM - 1:00PM"),
                      ChoiceChipWidget(chipName: "1:00PM - 2:00PM "),
                      ChoiceChipWidget(chipName: "2:00PM - 3:00PM"),
                      ChoiceChipWidget(chipName: "3:00PM - 4:00PM"),
                      ChoiceChipWidget(chipName: "4:00PM - 5:00PM"),
                      ChoiceChipWidget(chipName: "5:00PM - 6:00PM"),
                      ChoiceChipWidget(chipName: "6:00PM - 7:00PM"),
                      ChoiceChipWidget(chipName: "7:00PM - 8:00PM"),
                    ],
                  )
                ],
              )),
          Container(
              child: OutlinedButton(
            onPressed: () {
              //addUser();
              try {
                print("object ${selectedChip}");
                print("object ${selectedDate}");

                CollectionReference collection = FirebaseFirestore.instance.collection("day");
                Day data = Day();
                data.saloonID = "";
                data.date = "";
                TimeSlot timeslot = TimeSlot();
                timeslot.status = "Open";
                timeslot.startTime = "";
                timeslot.endTime = "";
                data.timeSlotsList!.add(timeslot);
                SlotDetails slotDetails = SlotDetails();
                slotDetails.customerEmail = "";
                slotDetails.service = "";
                slotDetails.customerPhone = "";
                slotDetails.customerName = "";
                timeslot.timeSlotsDetails!.add(slotDetails);


                collection.add(data.toMap());
                print("object222 done ");
              }catch(e){
                print("object222 exp "+e.toString());
              }
            },
            child: Text("Book Slot"),
          ))
          // Container(
          //   child: TimeRange(
          //     // fromTitle: Text('From', style: TextStyle(fontSize: 18, color: gray),),
          //     // toTitle: Text('To', style: TextStyle(fontSize: 18, color: gray),),
          //     //titlePadding: 20,
          //     textStyle: TextStyle(fontWeight: FontWeight.normal, color: Colors.black87),
          //     activeTextStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          //     borderColor: Colors.blueGrey,
          //     backgroundColor: Colors.transparent,
          //     activeBackgroundColor: Colors.orange,
          //     firstTime: TimeOfDay(hour: 9, minute: 00),
          //     lastTime: TimeOfDay(hour: 19, minute: 00),
          //     timeStep: 60,
          //     timeBlock: 0,
          //     onRangeCompleted: (range) {
          //       setState(() {
          //         _timeRange = range;
          //       });
          //     }
          //   )
          // )
          // Container(
          //   child: DateTimePicker(
          //     // initialSelectedDate: dt,
          //     // startDate: dt.add(Duration(days: 1)),
          //     // endDate: dt.add(Duration(days: 60)),
          //     startTime: DateTime(dt.year, dt.month, dt.day, 6),
          //     endTime: DateTime(dt.year, dt.month, dt.day, 18),
          //     timeInterval: Duration(minutes: 15),
          //     datePickerTitle: 'Pick your preferred date',
          //     timePickerTitle: 'Pick your preferred time',
          //     timeOutOfRangeError: 'Sorry shop is closed now',
          //     is24h: false,
          //     // onDateChanged: (date) {
          //     //   setState(() {
          //     //     _d1 = DateFormat('dd MMM, yyyy').format(date);
          //     //   });
          //     // },
          //     onTimeChanged: (time) {
          //       setState(() {
          //         _t1 = DateFormat('hh:mm:ss aa').format(time);
          //       });
          //     },
          //   )
          // )
          // TimeRange(
          //   // fromTitle: Text(
          //   //   'FROM',
          //   //   style: TextStyle(
          //   //     fontSize: 14,
          //   //     color: dark,
          //   //     fontWeight: FontWeight.w600,
          //   //   ),
          //   // ),
          //   // toTitle: Text(
          //   //   'TO',
          //   //   style: TextStyle(
          //   //     fontSize: 14,
          //   //     color: dark,
          //   //     fontWeight: FontWeight.w600,
          //   //   ),
          //   // ),
          //   //titlePadding: leftPadding,
          //   textStyle: TextStyle(
          //     fontWeight: FontWeight.normal,
          //     color: dark,
          //   ),
          //   activeTextStyle: TextStyle(
          //     fontWeight: FontWeight.bold,
          //     color: orange,
          //   ),
          //   borderColor: dark,
          //   activeBorderColor: dark,
          //   backgroundColor: Colors.transparent,
          //   activeBackgroundColor: dark,
          //   firstTime: TimeOfDay(hour: 9, minute: 00),
          //   lastTime: TimeOfDay(hour: 19, minute: 00),
          //   initialRange: _timeRange,
          //   timeStep: 10,
          //   timeBlock: 30,
          //   onRangeCompleted: (range) => setState(() => _timeRange = range),
          // ),
          // SizedBox(height: 30),
          // if (_timeRange != null)
          //   Padding(
          //     padding: const EdgeInsets.only(top: 8.0, left: leftPadding),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: <Widget>[
          //         Text(
          //           'Selected Range: ${_timeRange!.start.format(context)} - ${_timeRange!.end.format(context)}',
          //           style: TextStyle(fontSize: 20, color: dark),
          //         ),
          //         SizedBox(height: 20),
          //         MaterialButton(
          //           child: Text('Default'),
          //           onPressed: () =>
          //               setState(() => _timeRange = _defaultTimeRange),
          //           color: orange,
          //         )
          //       ],
          //     ),
          //   ),
        ]),
      ),
    );
  }
}
