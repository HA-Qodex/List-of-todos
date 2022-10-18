import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/views/todo_view.dart';

import '../models/todo_model.dart';
import '../services/todo_services.dart';

class HomeController extends GetxController {
  var todoList = <TodoModel>[].obs;
  var todoModel = TodoModel().obs;
  var page = 1;
  var scrollController = ScrollController().obs;
  var isMoreDataAvailable = true.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    getTodos();
    pagination();
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.value.dispose();
    super.onClose();
  }

  void getTodos() {
    isLoading.value = true;
    Map<String, dynamic> payLoad = {"page": page, "item": 10};
    TodoService(payLoad: payLoad).getData(onSuccess: (data) {
      if (data.isNotEmpty) {
        todoList.addAll(data);
        page++;
        isMoreDataAvailable(true);
      } else {
        isMoreDataAvailable(false);
      }
      isLoading.value = false;
    }, onError: (error) {
      isLoading.value = false;
      debugPrint("-------- TODO Error $error");
    });
  }

  void pagination() {
    scrollController.value.addListener(() {
      if (isMoreDataAvailable.value &&
          scrollController.value.position.pixels ==
              scrollController.value.position.maxScrollExtent) {
        getTodos();
      }
    });
  }

  void todoDetails({required String id}){
    TodoDetailsService(id: id).getData(
      onSuccess: (data){
        todoModel.value = data;
        Get.to(() => TodoPage(),
            transition: Transition.rightToLeft,
            duration: const Duration(milliseconds: 300));
      },
      onError: (error){
        debugPrint("-------------- Todo Details Error $error");
      }
    );
  }
}
