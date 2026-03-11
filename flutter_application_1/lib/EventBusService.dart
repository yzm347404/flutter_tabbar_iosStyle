import 'package:event_bus/event_bus.dart';

class EventBusService {
  static final EventBus _eventBus = EventBus();
  static EventBus get instance => _eventBus;
}

// 2. 定义事件类（类似 iOS 的 Notification name）
class LogoutEvent {
  final String userId;
  final String username;

  LogoutEvent(this.userId, this.username);
}
