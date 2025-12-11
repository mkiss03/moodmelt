import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/microtherapy_api.dart';
import '../domain/microtherapy_session.dart';

// Provider for the API
final microtherapyApiProvider = Provider<MicrotherapyApi>((ref) {
  return MicrotherapyApi();
});

// State for Stress Balloon
class StressBalloonStateModel {
  final StressBalloonState state;
  final String? reframedText;
  final String? errorMessage;

  StressBalloonStateModel({
    required this.state,
    this.reframedText,
    this.errorMessage,
  });

  StressBalloonStateModel copyWith({
    StressBalloonState? state,
    String? reframedText,
    String? errorMessage,
  }) {
    return StressBalloonStateModel(
      state: state ?? this.state,
      reframedText: reframedText ?? this.reframedText,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// Controller for Stress Balloon
class StressBalloonController extends StateNotifier<StressBalloonStateModel> {
  final MicrotherapyApi _api;

  StressBalloonController(this._api)
      : super(StressBalloonStateModel(state: StressBalloonState.idle));

  Future<void> submitThought(String thought) async {
    if (thought.trim().isEmpty) {
      state = state.copyWith(
        state: StressBalloonState.error,
        errorMessage: 'Kérlek, írj be valamit!',
      );
      return;
    }

    state = state.copyWith(
      state: StressBalloonState.loading,
      errorMessage: null,
    );

    try {
      final reframed = await _api.reframeThought(thought);

      state = state.copyWith(
        state: StressBalloonState.result,
        reframedText: reframed,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        state: StressBalloonState.error,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  void reset() {
    state = StressBalloonStateModel(state: StressBalloonState.idle);
  }
}

// Provider for the controller
final stressBalloonControllerProvider =
    StateNotifierProvider<StressBalloonController, StressBalloonStateModel>(
  (ref) {
    final api = ref.watch(microtherapyApiProvider);
    return StressBalloonController(api);
  },
);
