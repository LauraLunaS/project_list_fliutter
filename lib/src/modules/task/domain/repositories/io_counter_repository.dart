abstract class ICounterServerRepository {
  void responseCounterUpdate(Function function, Function functionAdapter);
  void requestCounterUpdate(String userId, Function function, Function functionAdapter);
}