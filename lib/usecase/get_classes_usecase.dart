import 'package:edu_world/usecase/base/base_output.dart';

class GetClassesUsecase {
  GetClassesUsecase();

  GetClassesOutput execute(GetClassesInput input) {
    if (input.school.contains('Tiểu học')) {
      return const GetClassesOutput(successful: true, classes: [1, 2, 3, 4, 5]);
    } else if (input.school.contains('THCS')) {
      return const GetClassesOutput(successful: true, classes: [6, 7, 8, 9]);
    } else if (input.school.contains('THPT')) {
      return const GetClassesOutput(successful: true, classes: [10, 11, 12]);
    }

    return const GetClassesOutput(classes: [], successful: false);
  }
}

class GetClassesInput {
  final String school;

  GetClassesInput(this.school);
}

class GetClassesOutput extends BaseOutput {
  final List<int> classes;

  const GetClassesOutput({super.successful, required this.classes});
}
