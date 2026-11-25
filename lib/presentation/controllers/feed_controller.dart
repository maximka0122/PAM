import 'package:flutter/foundation.dart';
import '../../domain/entities/feed_entity.dart';
import '../../domain/usecases/get_feed_usecase.dart';

enum FeedStatus { initial, loading, loaded, error }

class FeedState {
  final FeedStatus status;
  final FeedEntity? feed;
  final String? errorMessage;

  const FeedState({
    this.status = FeedStatus.initial,
    this.feed,
    this.errorMessage,
  });

  FeedState copyWith({
    FeedStatus? status,
    FeedEntity? feed,
    String? errorMessage,
  }) {
    return FeedState(
      status: status ?? this.status,
      feed: feed ?? this.feed,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class FeedController extends ValueNotifier<FeedState> {
  final GetFeedUseCase getFeedUseCase;

  FeedController({required this.getFeedUseCase}) : super(const FeedState());

  Future<void> fetchFeed() async {
    value = value.copyWith(status: FeedStatus.loading);
    try {
      final feed = await getFeedUseCase();
      value = value.copyWith(
        status: FeedStatus.loaded,
        feed: feed,
      );
    } catch (e) {
      value = value.copyWith(
        status: FeedStatus.error,
        errorMessage: e.toString(),
      );
    }
  }
}
