import 'package:edu_world/di/di.dart';
import 'package:edu_world/domain/repository/course_repository.dart';
import 'package:edu_world/usecase/base/base_output.dart';

class GetReviewsScoreUsecase {
  final CourseRepository _courseRepository = getIt.get();

  Future<GetReviewScoreOutput> execute(GetReviewScoreInput input) async {
    final response = await _courseRepository.getReviews(input.courseId);

    if (response.isEmpty) {
      return const GetReviewScoreOutput(message: 'Chưa có đánh giá', score: 0);
    }

    final score = response.fold<double>(0, (sum, review) => sum + review.score.toDouble()) / response.length;
    return GetReviewScoreOutput(message: score.toString(), score: score);
  }
}

class GetReviewScoreInput {
  final String courseId;

  const GetReviewScoreInput(this.courseId);
}

class GetReviewScoreOutput extends BaseOutput {
  final double score;

  const GetReviewScoreOutput({super.message, required this.score});
}
