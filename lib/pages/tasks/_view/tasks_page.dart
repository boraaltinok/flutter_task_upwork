import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_list_app/Utilities/PaddingUtility.dart';
import 'package:task_list_app/common/app_style.dart';

import '../../../model/task.dart';
import '../../../providers/provider.dart';
import '../../../service/network_service.dart';

final tasksProvider = FutureProvider<List<Task>>((ref) async {
  final networkService = ref.watch(networkServiceProvider);
  return networkService.getTasks();
});

class TasksPage extends StatelessWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emptySpace =
        MediaQuery.of(context).size.height / 10; // empty space screenHeight/10
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Text(
            'Tasks',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          buildDivider(),
          buildEmptySpace(emptySpace),
          Expanded(
            child: Consumer(
              builder: (context, ref, _) {
                final selectedTask = ref.watch(selectedTaskProvider);
                final tasksAsyncValue = ref.watch(tasksProvider);
                return tasksAsyncValue.when(
                  data: (tasks) {
                    return buildListView(tasks, selectedTask, ref);
                  },
                  loading: () => CircularProgressIndicator(),
                  error: (error, stackTrace) =>
                      Text('Error loading tasks: $error'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  ListView buildListView(List<Task> tasks, Task? selectedTask, WidgetRef ref) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index) {
        final task = tasks[index];
        final isSelected = task == selectedTask;
        return buildTaskTile(ref, task, context, isSelected);
      },
    );
  }

  GestureDetector buildTaskTile(
      WidgetRef ref, Task task, BuildContext context, bool isSelected) {
    return GestureDetector(
      onTap: () {
        //changing the state
        ref.read(selectedTaskProvider.notifier).state = task;
      },
      child: Padding(
        padding: PaddingUtility.smallAllDirPadding,
        child: Container(
          height: MediaQuery.of(context).size.height / 10,
          decoration: BoxDecoration(
            color: AppStyle.lightGrey,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(width: 1, color: Colors.grey.withOpacity(0.1)),
          ),
          child: Padding(
            padding: PaddingUtility.xSmallHorizontalPadding,
            child: buildTaskInfo(task, isSelected, context),
          ),
        ),
      ),
    );
  }

  Row buildTaskInfo(Task task, bool isSelected, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Text(
          task.title ?? '',
          style: isSelected
              ? Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold)
              : Theme.of(context).textTheme.titleMedium,
        )),
        Expanded(flex: 1, child: SizedBox()),
        Expanded(child: Text(task.dateTime?.toString().substring(0, 16) ?? '')),
      ],
    );
  }

  SizedBox buildEmptySpace(double emptySpace) {
    return SizedBox(
      height: emptySpace,
    );
  }

  Divider buildDivider() {
    return Divider(
      thickness: 3,
      indent: 5,
    );
  }
}
