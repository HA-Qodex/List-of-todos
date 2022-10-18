import '../models/todo_model.dart';
import 'main_service_request.dart';

class TodoService {

  Map<String, dynamic> payLoad;

  TodoService({required this.payLoad});

  void getData({
    Function()? beforeSend,
    Function(List<TodoModel> data)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    String url = "/todos?_page=${payLoad["page"]}&_limit=${payLoad["item"]}";
    APIRequest(url: url).get(
        beforeSend: () => {
          if (beforeSend != null) beforeSend(),
        },
        onSuccess: (data) => {
          onSuccess!((data as List)
              .map((e) => TodoModel.fromJson(e))
              .toList())
        },
        onError: (error) => {
          if (error != null)
            {
              onError!(error),
            }
        });
  }
}

class TodoDetailsService {

  String id;

  TodoDetailsService({required this.id});

  void getData({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    String url = "/todos/$id";
    APIRequest(url: url).get(
        beforeSend: () => {
          if (beforeSend != null) beforeSend(),
        },
        onSuccess: (data) => {
          onSuccess!(TodoModel.fromJson(data))
        },
        onError: (error) => {
          if (error != null)
            {
              onError!(error),
            }
        });
  }
}
