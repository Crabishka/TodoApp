import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:todolist_for_fittin/model/todo_job.dart';
import 'package:todolist_for_fittin/modelview/AppState.dart';

class MainTodoPage extends StatelessWidget {
  const MainTodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final data = Provider.of<AppState>(context).getTodoJobs();
    final status = Provider.of<AppState>(context).isFinishedShowed;
    return Scaffold(
      backgroundColor: themeData.colorScheme.background,
      appBar: AppBar(
        backgroundColor: themeData.colorScheme.background,
        centerTitle: true,
        title: Text(
          'Мои дела',
          style: themeData.textTheme.headlineSmall,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(
                    "Выполнено - ${Provider.of<AppState>(context, listen: false).getNumberOfFinishedTask()}",
                    style: themeData.textTheme.bodyLarge?.copyWith(
                        color: themeData.colorScheme.tertiary,
                        fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        Provider.of<AppState>(context, listen: false)
                            .changeShowedStatus();
                      },
                      icon: Icon(
                        status ? Icons.visibility : Icons.visibility_off,
                        color: themeData.colorScheme.secondary,
                      ))
                ],
              ),
            ),
            Expanded(
              child: CustomScrollView(slivers: [
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      bool isVisible = !data[index].done ||
                          Provider.of<AppState>(context, listen: false)
                              .isFinishedShowed;
                      return Visibility(
                        visible: isVisible,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  getBorderGeometry(index, data.length)),
                          margin: EdgeInsets.zero,
                          child: Dismissible(
                            key: UniqueKey(),
                            onDismissed: (DismissDirection direction) {
                              if (direction == DismissDirection.endToStart) {
                                Provider.of<AppState>(context, listen: false)
                                    .removeTodoJobByObject(data[index]);
                              }
                              if (direction == DismissDirection.startToEnd) {}
                            },
                            confirmDismiss: (DismissDirection direction) async {
                              if (direction == DismissDirection.startToEnd) {
                                Provider.of<AppState>(context, listen: false)
                                    .changeTodoJobStatusByObject(
                                    data[index], true);
                                return false;
                              } else {
                                return true;
                              }
                            },
                            secondaryBackground: Container(
                              color: Theme.of(context).colorScheme.error,
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Icon(
                                  Icons.delete_outline,
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              ),
                            ),
                            background: Container(
                              color: Theme.of(context).colorScheme.secondary,
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Icon(
                                  Icons.check,
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              ),
                            ),
                            child: CheckboxListTile(
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                                title: Text(
                                  data[index].text,
                                  style: themeData.textTheme.bodyLarge,
                                ),
                                subtitle: data[index].deadline != null
                                    ? Text(
                                        data[index].deadline.toString(),
                                        style: themeData.textTheme.bodyMedium,
                                      )
                                    : null,
                                value: data[index].done,
                                onChanged: (value) {
                                  Provider.of<AppState>(context, listen: false)
                                      .changeTodoJobStatusByObject(
                                          data[index], value);
                                }),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 16,
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {
          Provider.of<AppState>(context, listen: false).addTodoJob(
              TodoJob(text: "Новая задача", deadline: DateTime.now()));
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }

  BorderRadiusGeometry getBorderGeometry(int index, int max) {
    if (index == 0) {
      return const BorderRadius.vertical(top: Radius.circular(8));
    }
    if (index == max - 1) {
      return const BorderRadius.vertical(bottom: Radius.circular(8));
    } else {
      return const BorderRadius.all(Radius.zero);
    }
  }
}