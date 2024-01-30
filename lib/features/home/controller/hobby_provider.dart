import '/features/home/service/home_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// [hobbyProvider] is used to provide the [Stream] of hobbies.
/// [hobbyProvider] uses firebase firestore to get the hobbies.

final hobbyProvider = StreamProvider.autoDispose((ref) async* {
  final homeService = HomeService();
  final stream = homeService
      .listenHobbies()
      .asyncMap((event) => ((event.data()?['user_hobbies'] ?? []) as List));

  yield* stream;
});
