abstract class IIoServerDatasource {
  void listeningProblemEvent(Function function, Function functionAdapter);
  void listeningIdentifyServerOutEvent(Function function);
  void listeningServiceState(Function function, Function functionAdapter);
}