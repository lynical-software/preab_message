import '../../preab_message.dart';

typedef UserFromJsonMapper = ChatUser Function(Map<String, dynamic> json);
typedef UserToJsonMapper = Map<String, dynamic> Function(ChatUser? user);
