import 'package:flutter/material.dart';
import 'package:flutter_git_search/constants/colors.dart';

import '../../../../../models/project.dart';

class ProjectTile extends StatelessWidget {
  const ProjectTile(this.project);
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
            style: TextStyle(
                color: Color(0xFF0366D6),
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              project.description,
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF586069)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              project.language == ""
                  ? Container()
                  : Row(
                      children: <Widget>[
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.programingColors[project.language],
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(project.language)
                      ],
                    ),
              Text(
                "Atualizado em ${project.updatedAtToString}",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 8,
                    color: Color(0xFF586069)),
              )
            ],
          ),
        ],
      ),
    );
  }
}
