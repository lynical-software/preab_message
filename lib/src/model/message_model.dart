import 'package:preab_message/preab_message.dart';

class MessageModel {
  MessageModel({
    required this.id,
    required this.message,
    required this.timestamp,
    required this.sender,
    required this.receiver,
    required this.room,
    required this.chatAttachment,
    required this.customData,
    required this.created,
    required this.updated,
  });

  final String id;
  static const String idKey = "id";

  final String message;
  static const String messageKey = "message";

  final int timestamp;
  static const String timestampKey = "timestamp";

  final ChatUser? sender;
  static const String senderKey = "sender";

  final ChatUser? receiver;
  static const String receiverKey = "receiver";

  final String room;
  static const String roomKey = "room";

  final ChatAttachment? chatAttachment;
  static const String chatAttachmentKey = "chat_attachment";

  final MapData? customData;
  static const String customDataKey = "custom_data";

  final DateTime? created;
  static const String createdKey = "created";

  final DateTime? updated;
  static const String updatedKey = "updated";

  MessageModel copyWith({
    String? id,
    String? message,
    int? timestamp,
    ChatUser? sender,
    ChatUser? receiver,
    String? room,
    ChatAttachment? chatAttachment,
    MapData? customData,
    DateTime? created,
    DateTime? updated,
  }) {
    return MessageModel(
      id: id ?? this.id,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
      room: room ?? this.room,
      chatAttachment: chatAttachment ?? this.chatAttachment,
      customData: customData ?? this.customData,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    final userJsonMapper = PreabSetting.instance.userJsonMapper;
    return MessageModel(
      id: json["id"] ?? "",
      message: json["message"] ?? "",
      timestamp: json["timestamp"] ?? 0,
      sender: json["sender"] == null ? null : userJsonMapper(json["sender"]),
      receiver: json["receiver"] == null ? null : userJsonMapper(json["receiver"]),
      room: json["room"] ?? "",
      chatAttachment: json["chat_attachment"] == null ? null : ChatAttachment.fromJson(json["chat_attachment"]),
      customData: json["custom_data"],
      created: json["created"] == null ? null : DateTime.parse(json["created"]),
      updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
    );
  }

  Map<String, dynamic> toJson() {
    final userToJsonMapper = PreabSetting.instance.userToJsonMapper;
    return {
      "id": id,
      "message": message,
      "timestamp": timestamp,
      "sender": userToJsonMapper(sender),
      "receiver": userToJsonMapper(receiver),
      "room": room,
      "chat_attachment": chatAttachment?.toJson(),
      "custom_data": customData,
      "created": created?.toIso8601String(),
      "updated": updated?.toIso8601String(),
    };
  }
}

class ChatAttachment {
  ChatAttachment({
    required this.type,
    required this.url,
    required this.fileName,
  });

  final String type;
  static const String typeKey = "type";

  final String url;
  static const String urlKey = "url";

  final String fileName;
  static const String fileNameKey = "file_name";

  ChatAttachment copyWith({
    String? type,
    String? url,
    String? fileName,
  }) {
    return ChatAttachment(
      type: type ?? this.type,
      url: url ?? this.url,
      fileName: fileName ?? this.fileName,
    );
  }

  factory ChatAttachment.fromJson(Map<String, dynamic> json) {
    return ChatAttachment(
      type: json["type"] ?? "",
      url: json["url"] ?? "",
      fileName: json["file_name"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "url": url,
        "file_name": fileName,
      };
}
