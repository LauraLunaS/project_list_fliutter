abstract class ICounterServerRepository {
  void responseCounterUpdate(Function function);
  void requestCounterUpdate(String userId);
}