import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:todo_app/controllers/home_controller.dart';
import 'package:todo_app/views/todo_view.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFEEEEEE),
        appBar: AppBar(
          title: const Text("TODO"),
          centerTitle: true,
          elevation: 0,
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: GetX<HomeController>(
              builder: (controller) {
                return Stack(
                  children: [
                    RefreshIndicator(
                      onRefresh: () {
                        controller.page = 1;
                        controller.todoList.clear();
                        controller.getTodos();
                        return Future<void>.delayed(
                            const Duration(milliseconds: 2000));
                      },
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          controller: controller.scrollController.value,
                          itemCount: controller.todoList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3.0),
                              child: GestureDetector(
                                onTap: (){
                                  controller.todoDetails(id:controller.todoList[index].id.toString());
                                },
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                      height: 70,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFEBEBEB),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width*0.12,
                                          height: double.infinity,
                                          padding: const EdgeInsets.all(8),
                                          decoration: const BoxDecoration(
                                              color: Color(0xFFDEDEDE),
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10))),
                                          child: CircleAvatar(
                                            child: Text(
                                              controller.todoList[index].userId
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "ID: ${controller.todoList[index].id}",
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                "Title: ${controller.todoList[index].title}",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 8.0),
                                          child: RoundCheckBox(
                                            onTap: (value) {
                                              controller.todoList[index].completed =
                                                  value;
                                            },
                                            uncheckedColor: Colors.grey.shade300,
                                            isChecked: controller
                                                .todoList[index].completed,
                                            size: 20,
                                            checkedWidget: const Icon(Icons.check, color: Colors.white,size: 18,),
                                            isRound: true,
                                          ),
                                        )
                                      ])),
                                ),
                              ),
                            );
                          }),
                    ),
                    Visibility(
                      visible: controller.isLoading.value &&
                              controller.isMoreDataAvailable.value
                          ? true
                          : false,
                      child: Positioned.fill(
                          child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Container(
                            height: 40,
                            width: 40,
                            padding: const EdgeInsets.all(10.0),
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                            child: const CircularProgressIndicator(
                              strokeWidth: 3,
                            ),
                          ),
                        ),
                      )),
                    ),
                    // SnackBar(content: Container(width: MediaQuery.of(context).size.width,))
                  ],
                );
              },
            )));
  }
}
