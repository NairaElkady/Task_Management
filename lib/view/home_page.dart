// ignore_for_file: unnecessary_string_escapes

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../common/add_new_task.dart';
import '../provider/service_provider.dart';
import '../widget/card_task.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskData = ref.watch(fetchDateProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: ListTile(
          leading: const CircleAvatar(
            backgroundImage:
                NetworkImage('https://www.woolha.com/media/2020/03/eevee.png'),
            minRadius: 8,
            maxRadius: 24,
            // backgroundColor: Colors.amber.shade200,
            // radius: 25,
            // child: Image.asset(
            //   "assets/images.png",

            //   // height: 40,
            //   // width: 30,
            //   //fit: BoxFit.cover,
            // ),
          ),
          title: Text(
            "Heloo",
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          ),
          subtitle: const Text(
            " Naira Elkady ",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(children: [
              IconButton(
                  onPressed: () {}, icon: const Icon(CupertinoIcons.calendar)),
              IconButton(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.bell),
              ),
            ]),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
          ),
          child: Column(children: [
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today\'s Task",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Friday, 11 May",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 165, 191, 221),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 15)),
                  onPressed: () => showModalBottomSheet(
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17)),
                    context: context,
                    builder: (context) => AddNewTask(),
                  ),
                  child: Text(
                    " + New Task",
                    style: TextStyle(color: Colors.grey.shade800),
                  ),
                ),
              ],
            ),
            const Gap(20),
            //card list Task

            ListView.builder(
              itemCount: taskData.value?.length ?? 0,
              shrinkWrap: true,
              itemBuilder: (context, index) => CardTask(getIndex: index),
            ),
          ]),
        ),
      ),
    );
  }
}
