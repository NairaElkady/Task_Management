import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:taskmanagemet/provider/service_provider.dart';

class CardTask extends ConsumerWidget {
  const CardTask({
    super.key,
    required this.getIndex,
  });

  final int getIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskData = ref.watch(fetchDateProvider);
    return taskData.when(
        data: (taskData) {
          Color categoryColor = Colors.white;
          final getCategory = taskData[getIndex].category;

          switch (getCategory) {
            case 'Learning':
              categoryColor = Colors.green;
              break;

            case 'Learning':
              categoryColor = Colors.blue.shade700;
              break;

            case 'Learning':
              categoryColor = Colors.amber.shade700;
              break;
          }

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            width: double.infinity,
            height: 140,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: categoryColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                  width: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(taskData[getIndex].titleTask),
                          subtitle: Text(taskData[getIndex].description),
                          trailing: Transform.scale(
                            scale: 1.5,
                            child: Checkbox(
                              activeColor: Colors.blue.shade800,
                              shape: const CircleBorder(),
                              value: taskData[getIndex].isDone,
                              // ignore: avoid_print
                              onChanged: (value) => ref
                                  .read(serviceProvider)
                                  .updateTask(taskData[getIndex].docID, value!),
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(0, -15),
                          child: Container(
                            child: Column(children: [
                              Divider(
                                thickness: 1.5,
                                color: Colors.grey.shade300,
                              ),
                              Row(
                                children: [
                                  const Text("Today"),
                                  const Gap(12),
                                  Text(taskData[getIndex].timeTask),
                                ],
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        error: ((error, stackTrace) => Center(
              child: Text(stackTrace.toString()),
            )),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }
}
