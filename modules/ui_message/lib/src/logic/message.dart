import '/src/logic/notice/notification_mixin.dart';
import 'message/message_mixin.dart';

MessageHandler $message = MessageHandler._();

class MessageHandler with ContextAttachable, MessageMixin, NotificationMixin {
  MessageHandler._();
}
