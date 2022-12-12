import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskit/models/task.dart';
import 'package:taskit/theme.dart';
import 'package:taskit/widgets/inputField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final firestore = FirebaseFirestore.instance.collection('tasks');

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _endTime = DateFormat("hh:mm a")
      .format(DateTime.now().add(Duration(hours: 1)))
      .toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Add Task",
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 20, color: primaryTxtClr),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: primaryTxtClr),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                InputField(
                  title: "Task name",
                  placeholder: "Enter your task name",
                  controller: _nameController,
                ),
                InputField(
                  title: "Note",
                  placeholder: "Enter your note",
                  controller: _noteController,
                ),
                InputField(
                  title: "Tag",
                  placeholder: "Enter your tag",
                  controller: _tagController,
                ),
                InputField(
                  title: "Date",
                  placeholder: DateFormat.yMd().format(_selectedDate),
                  widget: IconButton(
                    onPressed: () => _getDate(),
                    icon: const Icon(
                      Icons.calendar_today_outlined,
                      color: secondaryTxtClr,
                      size: 18.0,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InputField(
                        title: "Start time",
                        placeholder: _startTime,
                        widget: IconButton(
                          onPressed: () => _getTime(isStartTime: true),
                          icon: const Icon(
                            Icons.schedule_outlined,
                            color: secondaryTxtClr,
                            size: 18.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: InputField(
                        title: "End time",
                        placeholder: _endTime,
                        widget: IconButton(
                          onPressed: () => _getTime(isStartTime: false),
                          icon: const Icon(
                            Icons.schedule_outlined,
                            color: secondaryTxtClr,
                            size: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: ActionBar(
        onAdd: _onSubmit,
      ),
    );
  }

  _setData() async {
    final data = Task(
            name: _nameController.text,
            note: _noteController.text,
            tag: _tagController.text,
            date: DateFormat.yMd().format(_selectedDate),
            startTime: _startTime,
            endTime: _endTime)
        .toFirestore();
    try {
      await firestore.add(data).then((documentSnapshot) =>
          print("Added Data with ID: ${documentSnapshot.id}"));
    } catch (e) {
      print(e);
    }
  }

  _getDate() async {
    DateTime? _datePicker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2016),
        lastDate: DateTime(2023),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context)
                .copyWith(colorScheme: ColorScheme.light(primary: actionBgClr)),
            child: child!,
          );
        });

    if (_datePicker != null) {
      setState(() {
        _selectedDate = _datePicker;
      });
    }
  }

  _getTime({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    if (pickedTime == null) {
      print("Time canceled");
    } else {
      String _formattedTime = pickedTime.format(context);

      if (isStartTime) {
        setState(() {
          _startTime = _formattedTime;
        });
      } else {
        setState(() {
          _endTime = _formattedTime;
        });
      }
    }
  }

  _showTimePicker() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(
          hour: int.parse(_startTime.split(":")[0]),
          minute: int.parse(_startTime.split(":")[1].split(" ")[0])),
      initialEntryMode: TimePickerEntryMode.input,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context)
              .copyWith(colorScheme: ColorScheme.light(primary: actionBgClr)),
          child: child!,
        );
      });

  _onSubmit() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop();
      _setData();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("New task added"),
        backgroundColor: actionBgClr,
      ));
    }
  }
}

class ActionBar extends StatelessWidget {
  final Function onAdd;
  const ActionBar({
    Key? key,
    required this.onAdd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 16.0),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  fixedSize: const Size(120, 45)),
              onPressed: () => Navigator.of(context).pop(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.delete_outline_rounded,
                    size: 18.0,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Discard',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.red),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: actionBgClr, fixedSize: const Size(120, 45)),
              onPressed: () => onAdd(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.add,
                    size: 18.0,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Add Task',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
