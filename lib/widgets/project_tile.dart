import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/user_project.dart';

class ProjectTile extends StatelessWidget {
  const ProjectTile({
    super.key,
    required this.project,
  });
  final Project project;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            project.name,
            style: const TextStyle(color: Color(0xFF0366D6), fontSize: 14, fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              project.description,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Color(0xFF586069)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              if (project.language.isNotEmpty)
                Row(
                  children: <Widget>[
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kColorMap[project.language],
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(project.language)
                  ],
                ),
              Text(
                "Atualizado em ${project.updatedAtToString}",
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 8, color: Color(0xFF586069)),
              )
            ],
          ),
        ],
      ),
    );
  }
}
