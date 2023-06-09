import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taskly_new/screen/auth/auth_view.dart';

import '../../../common/category_tile.dart';
import '../home_viewmodel.dart';

class HomeBody extends StatefulWidget {
  final HomeViewmodel viewmodel;

  const HomeBody({Key? key, required this.viewmodel}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final _taskController = TextEditingController();
  final _categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                scrollable: true,
                backgroundColor: theme.colorScheme.background,
                title: Text(
                  "Add task",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                content: Column(
                  children: [
                    TextFormField(
                      controller: _taskController,
                      decoration: const InputDecoration(
                        hintText: "Task name",
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: theme.colorScheme.onBackground,
                      ),
                    ),
                    TextFormField(
                      controller: _categoryController,
                      decoration: const InputDecoration(
                        hintText: "Task category",
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: theme.colorScheme.onBackground,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onPressed: () {
                        // widget.viewmodel.addTask(
                        //   Task(
                        //     name: _taskController.text.trim(),
                        //     category:
                        //         _categoryController.text.trim().toLowerCase(),
                        //     isCompleted: false,
                        //   ),
                        // );
                        widget.viewmodel
                            .addTaskFirebase(
                              _taskController.text.trim(),
                              _categoryController.text.trim().toLowerCase(),
                            )
                            .then(
                              (value) =>
                                  ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Adding Successful!"),
                                ),
                              ),
                            );
                        _taskController.clear();
                        _categoryController.clear();
                        Navigator.pop(context);
                      },
                      color: theme.colorScheme.secondary,
                      child: Text(
                        "Confirm task",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: theme.colorScheme.background,
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
        label: Text(
          "Add task",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onPrimary,
          ),
        ),
        icon: const Icon(
          Icons.add_circle_outline,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Let's do\nsomething!",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onBackground,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await widget.viewmodel.signOutFromApp().then(
                              (val) => Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AuthView(),
                                  ),
                                  (route) => false),
                            );
                      },
                      icon: Icon(
                        Icons.exit_to_app_rounded,
                        color: theme.colorScheme.onBackground,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.tertiary,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: widget.viewmodel.todoStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text(
                          "Something went wrong, Please try again later!");
                    }

                    if (!snapshot.hasData) {
                      return const Text("Data does not exsist!");
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return SizedBox(
                      height: 150,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          CategoryTile(
                            categoryName: "Work",
                            taskData:
                                "${snapshot.data!.docs.where((element) => element.get('category') == 'work').toList().length} Tasks",
                          ),
                          CategoryTile(
                            categoryName: "Personal",
                            taskData:
                                "${snapshot.data!.docs.where((element) => element.get('category') == 'personal').toList().length} Tasks",
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "All tasks",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.tertiary,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: widget.viewmodel.todoStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text(
                          "Something went wrong, Please try again later!");
                    }

                    if (!snapshot.hasData) {
                      return const Text("Data does not exsist!");
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        //Task task = widget.viewmodel.taskList[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: RadioListTile(
                            activeColor:
                                snapshot.data!.docs[index].get('isCompleted') ==
                                        true
                                    ? theme.colorScheme.tertiary
                                    : theme.colorScheme.primary,
                            value: true,
                            groupValue:
                                snapshot.data!.docs[index].get('isCompleted') ??
                                    false,
                            onChanged: (value) {
                              widget.viewmodel
                                  .updateFirebase(snapshot.data!.docs[index].id)
                                  .then(
                                    (value) => ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                        content: Text("Adding Successful!"),
                                      ),
                                    ),
                                  );
                              //widget.viewmodel.deleteFirebase(snapshot.data!.docs[index].id);
                            },
                            title: Text(
                              snapshot.data!.docs[index].get('taskName'),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                decoration: snapshot.data!.docs[index]
                                            .get('isCompleted') ==
                                        true
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                color: snapshot.data!.docs[index]
                                            .get('isCompleted') ==
                                        true
                                    ? theme.colorScheme.tertiary
                                    : theme.colorScheme.onBackground,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
