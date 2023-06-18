import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_list_app/Utilities/PaddingUtility.dart';

import '../../../providers/provider.dart';
import 'package:task_list_app/model/task.dart';

class DetailsPage extends ConsumerWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTask =
        ref.watch(selectedTaskProvider); // watch the selected task

    var emptySpace =
        MediaQuery.of(context).size.height / 10; // empty space screenHeight/10
    return Column(
      // TODO: labels should be in app localization file
      children: [
        buildDetailText(selectedTask, context),
        buildDivider(),
        buildEmptySpace(emptySpace),
        //show details only if a task is selected
        selectedTask != null
            ? Expanded(
                child: buildDetailsInfo(selectedTask, context),
              )
            : Text('No task is selected yet.'),
      ],
    );
  }

  Padding buildDetailsInfo(Task selectedTask, BuildContext context) {
    return Padding(
      padding: PaddingUtility.smallAllDirPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            selectedTask.dateTime?.toString().substring(0, 16) ?? '',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Expanded(flex: 1, child: SizedBox()),
          Expanded(
              flex: 18,
              child: SingleChildScrollView(
                  child: Text(selectedTask.description ?? ''))),

          // Add more details here
        ],
      ),
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

  Text buildDetailText(Task? selectedTask, BuildContext context) {
    return Text(
      selectedTask == null ? 'Details' : selectedTask.title ?? "",
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
