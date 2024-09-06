abstract class ICounterDatasource {
  Future<void> requestCounterUpdate(String userId, Function function, Function functionAdapter);
}
