import '../repo/home_repository.dart';

class ReformatMessageDatetimeUseCase {
  final HomeRepository _homeRepository;

  ReformatMessageDatetimeUseCase(this._homeRepository);

  String call(dateTime) {
    return _homeRepository.reFormatMessageDateTime(dateTime);
  }
}
