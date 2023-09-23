import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:taskmanagemet/constant/app_style.dart';
import 'package:taskmanagemet/model/task_model.dart';
import 'package:taskmanagemet/provider/date_time_provider.dart';
import 'package:taskmanagemet/provider/radio_provider.dart';
import 'package:taskmanagemet/provider/service_provider.dart';
import 'package:taskmanagemet/widget/textfaild.dart';

import '../widget/date_time.dart';
import '../widget/radio_widget.dart';

class AddNewTask extends ConsumerWidget {
  AddNewTask({
    super.key,
  });
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateProv = ref.watch(dateProvider);
    return Container(
      padding: const EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height * 0.70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          width: double.infinity,
          child: Text(
            "New Task",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        Divider(
          thickness: 1.2,
          color: Colors.grey.shade200,
        ),
        const Gap(12),
        const Text(
          "Title Task",
          style: AppStyle.textstyle,
        ),
        const Gap(7),
        TextFaildWidget(
          hintText: "Add Task Name",
          maxLine: 1,
          textController: titleController,
        ),
        const Gap(13),
        const Text(
          "Description",
          style: AppStyle.textstyle,
        ),
        const Gap(7),
        TextFaildWidget(
          hintText: "Add Description",
          maxLine: 6,
          textController: descriptionController,
        ),
        const Gap(12),
        const Text(
          "Category",
          style: AppStyle.textstyle,
        ),
        Row(
          children: [
            Expanded(
              child: RadioWidget(
                titleRadio: "Learning",
                categColor: Colors.green,
                valueInput: 1,
                onChangedValue: () =>
                    ref.read(radioProvider.notifier).update((state) => 1),
              ),
            ),
            Expanded(
                child: RadioWidget(
              titleRadio: "Working",
              categColor: Colors.blue.shade700,
              valueInput: 2,
              onChangedValue: () =>
                  ref.read(radioProvider.notifier).update((state) => 2),
            )),
            Expanded(
                child: RadioWidget(
              titleRadio: "General",
              categColor: Colors.amber.shade700,
              valueInput: 3,
              onChangedValue: () =>
                  ref.read(radioProvider.notifier).update((state) => 3),
            )),
          ],
        ),
        const Gap(6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DateTimeWidget(
              titleText: "Date",
              valueText: dateProv,
              iconIcon: CupertinoIcons.calendar,
              onTap: () async {
                final getValue = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2028),
                );

                if (getValue != null) {
                  final format = DateFormat.yMd();
                  ref
                      .read(dateProvider.notifier)
                      .update((state) => format.format(getValue));
                }
              },
            ),
            const Gap(22),
            DateTimeWidget(
              titleText: "Time",
              valueText: ref.watch(timeProvider),
              iconIcon: CupertinoIcons.clock,
              onTap: () async {
                final getTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (getTime != null) {
                  ref
                      .read(timeProvider.notifier)
                      .update((state) => getTime.format(context));
                }
              },
            ),
          ],
        ),
        const Gap(13),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue.shade800,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: BorderSide(color: Colors.blue.shade800),
                    padding: const EdgeInsets.symmetric(vertical: 14)),
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
            ),
            const Gap(20),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14)),
                onPressed: () {
                  final getRadioValue = ref.read(radioProvider);
                  String category = "";
                  switch (getRadioValue) {
                    case 1:
                      category = 'Learning';
                      break;
                    case 2:
                      category = 'Working';
                      break;
                    case 3:
                      category = 'General';
                      break;
                  }

                  ref.read(serviceProvider).addNewTask(
                        TaskModel(
                            titleTask: titleController.text,
                            description: descriptionController.text,
                            category: category,
                            dateTask: ref.read(dateProvider),
                            timeTask: ref.read(timeProvider),
                            isDone: false),
                      );

                  print("Saving Task");

                  titleController.clear();
                  descriptionController.clear();
                  ref.read(radioProvider.notifier).update((state) => 0);
                  Navigator.pop(context);
                },
                child: const Text("Create"),
              ),
            )
          ],
        ),
      ]),
    );
  }
}
