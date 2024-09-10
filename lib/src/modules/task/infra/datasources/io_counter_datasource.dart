abstract class ICounterDatasource {
  void requestCounterUpdate(String userId, Function function, Function functionAdapter);
  void requestCounterUpdate2(String userId);
  void responseCounterUpdate(Function function);
}
