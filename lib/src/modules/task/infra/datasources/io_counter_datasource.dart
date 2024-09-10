abstract class ICounterDatasource {
  void requestCounterUpdate(String userId);
  void responseCounterUpdate(Function function);
}
