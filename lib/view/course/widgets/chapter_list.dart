import 'package:edu_world/bloc/course/course_bloc.dart';
import 'package:edu_world/data/resources/colors.dart';
import 'package:edu_world/data/resources/theme.dart';
import 'package:edu_world/model/entity/chapter.dart';
import 'package:edu_world/shared/utils/ext/build_context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChapterList extends StatefulWidget {
  final List<Chapter> chapters;

  const ChapterList(this.chapters, {super.key});

  @override
  State<ChapterList> createState() => _ChapterListState();
}

class _ChapterListState extends State<ChapterList> {
  late final List<bool> expandStates;

  @override
  void initState() {
    super.initState();

    expandStates = List.generate(widget.chapters.length, (_) => true);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => ExpansionTile(
        dense: true,
        title: Container(
          alignment: Alignment.centerLeft,
          child: Text(widget.chapters[index].name, style: AppTextTheme.interMedium12),
        ),
        tilePadding: EdgeInsets.zero,
        children: [LectureList(widget.chapters[index])],
      ),
      itemCount: widget.chapters.length,
      padding: EdgeInsets.zero,
    );
  }
}

class LectureList extends StatelessWidget {
  final CourseBloc bloc = CourseBloc();
  final Chapter chapter;

  LectureList(this.chapter, {super.key}) {
    bloc.add(GetLectures(chapter.lectureIds, chapter));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseBloc, CourseState>(
      bloc: bloc,
      buildWhen: (previous, current) =>
          (current is GetLectureListSuccess && current.chapter == chapter) || current is GetLectureListsLoading,
      builder: (context, state) {
        if (state is GetLectureListsLoading) return const CircularProgressIndicator();
        if (state is GetLectureListSuccess) {
          if (state.lectures.isEmpty) {
            return Container(
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColor.gray07))),
              child: Center(
                child: Text(
                  'Chưa có bài học nào',
                  style: AppTextTheme.interRegular12.copyWith(fontStyle: FontStyle.italic),
                ),
              ),
            );
          }
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            width: context.screenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: state.lectures
                  .map(
                    (e) => Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(e.$2, style: AppTextTheme.interRegular12),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          );
        }

        return Container();
      },
    );
  }
}
