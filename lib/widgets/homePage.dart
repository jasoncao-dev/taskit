import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskit/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskit/widgets/taskCard.dart';
import 'dateActionRow.dart';
import 'dropdownWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  late Stream<QuerySnapshot> _tasksStream = FirebaseFirestore.instance
      .collection('tasks')
      .where('date', isEqualTo: DateFormat.yMd().format(_selectedDate))
      .snapshots();
  late Stream<QuerySnapshot> _searchStream = FirebaseFirestore.instance
      .collection('tasks')
      .where(queryField, isEqualTo: queryValue)
      .snapshots();
  Icon visibleIcon = const Icon(
    Icons.search,
    color: primaryTxtClr,
    size: 28,
  );
  late Widget searchBar = SizedBox();
  bool isInSearchMode = false;
  String queryField = "name";
  String queryValue = "";

  void _onDropdownChange(String newDropdownValue) {
    setState(() {
      queryField = newDropdownValue.toLowerCase();
    });
  }

  void _iconButtonClicked() {
    if (visibleIcon.icon == Icons.search) {
      setState(() {
        isInSearchMode = true;
        visibleIcon = const Icon(
          Icons.close,
          color: primaryTxtClr,
          size: 28,
        );
        searchBar = Row(
          children: [
            Expanded(
              child: SizedBox(
                  width: 100,
                  height: 40,
                  child: DropdownWidget(onDropdownChange: _onDropdownChange)),
            ),
            TextField(
              textInputAction: TextInputAction.search,
              onSubmitted: (String text) {
                setState(() {
                  queryValue = text;
                  _searchStream = FirebaseFirestore.instance
                      .collection('tasks')
                      .where(queryField, isEqualTo: queryValue)
                      .snapshots();
                });
              },
              style: const TextStyle(
                color: primaryTxtClr,
                fontSize: 16.0,
              ),
              decoration: const InputDecoration(
                constraints: BoxConstraints.tightFor(width: 205),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: actionBgClr, width: 2.0)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: borderClr, width: 1.0),
                ),
                hintText: 'Search tasks',
                hintStyle: Themes.mutedTxt,
              ),
            ),
          ],
        );
      });
    } else {
      visibleIcon = const Icon(
        Icons.search,
        color: primaryTxtClr,
        size: 28,
      );
      searchBar = const SizedBox();
      isInSearchMode = false;
      queryValue = "";
      _searchStream = FirebaseFirestore.instance
          .collection('tasks')
          .where(queryField, isEqualTo: queryValue)
          .snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: searchBar,
        elevation: 0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
            child: IconButton(
                onPressed: () {
                  setState(() {
                    _iconButtonClicked();
                  });
                },
                icon: visibleIcon),
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
                      horizontal: 16.0, vertical: 16.0),
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
                              _tasksStream = FirebaseFirestore.instance
                                  .collection('tasks')
                                  .where('date',
                                      isEqualTo: DateFormat.yMd()
                                          .format(_selectedDate))
                                  .snapshots();
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
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
            child: Text(
              (!isInSearchMode) ? 'Tasks' : 'Results',
              style: Themes.heading,
              textAlign: TextAlign.start,
            ),
          ),
          (!isInSearchMode)
              ? StreamBuilder<QuerySnapshot>(
                  stream: _tasksStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                          child: Column(
                        children: [
                          Image.asset(
                            'images/error.png',
                            width: 150,
                          ),
                          const SizedBox(
                            height: 18.0,
                          ),
                          const Text("Uh oh, something went wrong..."),
                        ],
                      ));
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: actionBgClr,
                      ));
                    }

                    if (snapshot.data!.docs.isEmpty) {
                      return Center(
                          child: Column(
                        children: [
                          Image.asset(
                            'images/empty.png',
                            width: 150,
                          ),
                          const SizedBox(
                            height: 18.0,
                          ),
                          const Text(
                              "Seriously, you have nothing done today?!"),
                        ],
                      ));
                    }

                    return Expanded(
                      child: ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;
                              return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: TaskCard(
                                    name: data['name'] ?? 'N/A',
                                    note: data['note'] ?? 'N/A',
                                    tag: data['tag'] ?? 'N/A',
                                    startTime: data['startTime'] ?? 'N/A',
                                    endTime: data['endTime'] ?? 'N/A',
                                  ));
                            })
                            .toList()
                            .cast(),
                      ),
                    );
                  },
                )
              : StreamBuilder<QuerySnapshot>(
                  stream: _searchStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                          child: Column(
                        children: [
                          Image.asset(
                            'images/error.png',
                            width: 150,
                          ),
                          const SizedBox(
                            height: 18.0,
                          ),
                          const Text("Uh oh, something went wrong..."),
                        ],
                      ));
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: actionBgClr,
                      ));
                    }

                    if (snapshot.data!.docs.isEmpty) {
                      return Center(
                          child: Column(
                        children: [
                          Image.asset(
                            'images/empty.png',
                            width: 150,
                          ),
                          const SizedBox(
                            height: 18.0,
                          ),
                          const Text("No results found"),
                        ],
                      ));
                    }

                    return Expanded(
                      child: ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;
                              return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: TaskCard(
                                    name: data['name'] ?? 'N/A',
                                    note: data['note'] ?? 'N/A',
                                    tag: data['tag'] ?? 'N/A',
                                    startTime: data['startTime'] ?? 'N/A',
                                    endTime: data['endTime'] ?? 'N/A',
                                    date: data['date'] ?? 'N/A',
                                  ));
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
