abstract class ICounterDatasource {
  void requestCounterUpdate(String userId, Function function, Function functionAdapter);
  void responseCounterUpdate(Function function, Function functionAdapter);
}
