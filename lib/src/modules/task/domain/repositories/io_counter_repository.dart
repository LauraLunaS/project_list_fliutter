abstract class ICounterServerRepository {
  void responseCounterUpdate(Function function);
  void requestCounterUpdate(String userId, Function function, Function functionAdapter);
  void requestCounterUpdate2(String userId);
}