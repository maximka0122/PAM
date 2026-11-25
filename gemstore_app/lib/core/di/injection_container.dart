import '../network/api_client.dart';
import '../../data/datasources/feed_remote_datasource.dart';
import '../../data/repositories/feed_repository_impl.dart';
import '../../domain/repositories/feed_repository.dart';
import '../../domain/usecases/get_feed_usecase.dart';
import '../../domain/usecases/get_product_details_usecase.dart';
import '../../presentation/controllers/feed_controller.dart';
import '../../presentation/controllers/product_detail_controller.dart';

class ServiceLocator {
  static late final ApiClient apiClient;
  static late final FeedRemoteDataSource remoteDataSource;
  static late final FeedRepository repository;
  static late final GetFeedUseCase getFeedUseCase;
  static late final GetProductDetailsUseCase getProductDetailsUseCase;

  static void init() {
    apiClient = ApiClient();
    remoteDataSource = FeedRemoteDataSourceImpl(apiClient: apiClient);
    repository = FeedRepositoryImpl(remoteDataSource: remoteDataSource);
    getFeedUseCase = GetFeedUseCase(repository);
    getProductDetailsUseCase = GetProductDetailsUseCase(repository);
  }

  static FeedController createFeedController() {
    return FeedController(getFeedUseCase: getFeedUseCase);
  }

  static ProductDetailController createProductDetailController() {
    return ProductDetailController(getProductDetailsUseCase: getProductDetailsUseCase);
  }
}
