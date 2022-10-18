import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

import '../controllers/home_controller.dart';

class TodoPage extends StatelessWidget {
  TodoPage({Key? key}) : super(key: key);

  final todoController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: const Color(0xFFEEEEEE),
      appBar: AppBar(
        title: const Text("TODO Details"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 3,
          child: Container(
            padding: const EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height*0.2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: const Color(0xFFEBEBEB),
              border: Border.all(color: Colors.grey.shade300)
            ),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    child: Text(
                      todoController.todoModel.value.userId.toString(),
                      style: const TextStyle(
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: Text(
                      todoController.todoModel.value.title.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  RoundCheckBox(
                    onTap: (value) {
                      todoController.todoModel.value.completed = value;
                    },
                    uncheckedColor: Colors.grey.shade300,
                    isChecked: todoController.todoModel.value.completed,
                    size: 20,
                    checkedWidget: const Icon(Icons.check, color: Colors.white,size: 18,),
                    isRound: true,
                  ),
                ],
              ),
              Expanded(
                child: Center(
                  child: Text(
                    todoController.todoModel.value.id.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],),
          ),
        ),
      ),
    );
  }
}
