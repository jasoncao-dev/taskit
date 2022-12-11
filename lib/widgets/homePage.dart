import 'package:flutter/material.dart';
import 'package:taskit/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: Row(
        children: <Widget>[
          Expanded(
            child: Container(
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
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: const [
                        DateActionRow(),
                      ],
                    ))),
          ),
        ],
      ),
    );
  }
}

class DateActionRow extends StatelessWidget {
  const DateActionRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Expanded(
          child: CurrentDate(),
        ),
        AddTaskButton(),
      ],
    );
  }
}

class CurrentDate extends StatelessWidget {
  const CurrentDate({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'December 10, 2022',
          style: TextStyle(
              color: secondaryTxtClr,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 8.0,
        ),
        Text(
          'Today',
          style: TextStyle(
              color: primaryTxtClr, fontSize: 28, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: actionBgClr, fixedSize: const Size(120, 45)),
      onPressed: () {},
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
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
