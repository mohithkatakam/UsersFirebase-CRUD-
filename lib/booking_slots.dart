import 'package:flutter/material.dart';

class BookedSlots extends StatefulWidget {
  const BookedSlots({Key? key}) : super(key: key);

  @override
  State<BookedSlots> createState() => _BookedSlotsState();
}

class _BookedSlotsState extends State<BookedSlots> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bookings")
      ),
      body: Container(

      ),
    );
  }
}
