import 'package:flutter/material.dart';
import 'package:task_list_app/pages/tasks/_view/tasks_page.dart';

import 'details/_view/details_page.dart';
class TaskAndDetailPage extends StatefulWidget {
  const TaskAndDetailPage({Key? key}) : super(key: key);

  @override
  State<TaskAndDetailPage> createState() => _TaskAndDetailPageState();
}

class _TaskAndDetailPageState extends State<TaskAndDetailPage> {
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Expanded(child: TasksPage()),
        VerticalDivider(thickness: 3,),
        Expanded(child: DetailsPage())
      ],
    );
  }
}
