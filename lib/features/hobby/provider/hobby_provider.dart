import '/features/hobby/service/hobby_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// [hobbyProvider] is used to provide the [Stream] of hobbies.
/// [hobbyProvider] uses firebase firestore to get the hobbies.
final hobbyProvider = StreamProvider((ref) async* {
  final hobbyService = HobbyService();
  final stream = hobbyService
      .listen()
      .asyncMap((event) => ((event.data()?['user_hobbies'] ?? []) as List));

  yield* stream;
});
