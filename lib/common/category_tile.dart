import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final String categoryName;
  final String taskData;
  const CategoryTile({Key? key, required this.categoryName, required this.taskData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      width: 220,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            categoryName,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.tertiary,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            taskData,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: categoryName == 'Work'
                  ? theme.colorScheme.primary
                  : theme.colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
