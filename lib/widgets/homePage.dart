import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskit/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dateActionRow.dart';

final firestore = FirebaseFirestore.instance.collection('tasks');

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  late final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('tasks').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: primaryTxtClr,
                  size: 28,
                )),
          )
        ],
      ),
      backgroundColor: primaryBgClr,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              width: double.infinity,
              height: 220,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 2.5),
                      color: shadowClr,
                      blurRadius: 24.0),
                ],
              ),
              child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    children: [
                      const DateActionRow(),
                      Container(
                        margin: const EdgeInsets.only(top: 20.0),
                        child: DatePicker(
                          DateTime.now(),
                          onDateChange: (date) {
                            setState(() {
                              _selectedDate = date;
                            });
                          },
                          height: 100,
                          width: 80,
                          initialSelectedDate: DateTime.now(),
                          selectionColor: actionBgClr,
                          selectedTextColor: Colors.white,
                          dateTextStyle: const TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.w600,
                            color: primaryTxtClr,
                          ),
                          monthTextStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: secondaryTxtClr),
                          dayTextStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: secondaryTxtClr),
                        ),
                      )
                    ],
                  ))),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
            child: Text(
              'Tasks',
              style: Themes.heading,
              textAlign: TextAlign.start,
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: actionBgClr,
                ));
              }

              return Expanded(
                child: ListView(
                  children: snapshot.data!.docs
                      .map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        if (data['date'] ==
                            DateFormat.yMd().format(_selectedDate)) {
                          return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: TaskCard(
                                name: data['name'] ?? 'N/A',
                                note: data['note'] ?? 'N/A',
                                tag: data['tag'] ?? 'N/A',
                                startTime: data['startTime'] ?? 'N/A',
                                endTime: data['endTime'] ?? 'N/A',
                              ));
                        } else {
                          return const SizedBox();
                        }
                      })
                      .toList()
                      .cast(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final String name;
  final String note;
  final String tag;
  final String startTime;
  final String endTime;

  const TaskCard(
      {Key? key,
      required this.name,
      required this.note,
      required this.tag,
      required this.startTime,
      required this.endTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4.0),
      margin: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                name,
                style: Themes.taskName,
              ),
              const SizedBox(
                width: 8.0,
              ),
              Chip(
                  label: Text(
                    tag,
                    style: const TextStyle(color: actionBgClr, fontSize: 10.0),
                  ),
                  labelPadding:
                      const EdgeInsets.symmetric(vertical: -6, horizontal: 4),
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 8.0),
                  backgroundColor: primaryBgClr),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.schedule_outlined,
                size: 14.0,
                color: secondaryTxtClr,
              ),
              const SizedBox(
                width: 4.0,
              ),
              Text(
                startTime,
                style: Themes.mutedTxtSm,
              ),
              const SizedBox(
                width: 3.0,
              ),
              const Text(
                "-",
                style: Themes.mutedTxtSm,
              ),
              const SizedBox(
                width: 3.0,
              ),
              Text(
                endTime,
                style: Themes.mutedTxtSm,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 16.0),
            child: Text(
              note,
              style: const TextStyle(color: primaryTxtClr, fontSize: 12.0),
            ),
          ),
        ],
      ),
    );
  }
}
