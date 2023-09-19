import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:future_manager/future_manager.dart';
import 'package:skadi_firebase/skadi_firebase.dart';

import '../../preab_message.dart';
import '../services/message_service.dart';

class MessageController extends ChangeNotifier {
  final String roomId;
  final int limit;
  final MessageService _messageService;
  final FutureManager<List<MessageModel>> messageManager = FutureManager();

  bool hasMoreData = true;
  late RoomModel room;

  StreamSubscription<MessageModel?>? _subscription;

  void _addNewMessage(MessageModel message) {
    messageManager.modifyData((data) => [message, ...data!]);
  }

  void _clearMyUnread() async {
    RoomService.instance.clearMyUnread(roomId);
  }

  MessageController(this.roomId, [this.limit = 20]) : _messageService = MessageService(roomId) {
    _clearMyUnread();
    messageManager.execute(() async {
      room = await RoomService.instance.getOneRoom(roomId);
      var data = await _messageService.getInitialMessage(limit: limit);
      hasMoreData = data.length >= limit;
      return data;
    });
    _subscription = _messageService.recentMessageStream.listen((message) {
      if (messageManager.hasData && message != null) {
        if (!message.isMine) {
          _clearMyUnread();
          _addNewMessage(message);
        }
      }
    });
  }

  Future<MessageModel> sendMessage({required String message, Map<String, dynamic>? customData, File? file}) async {
    var me = PreabSetting.instance.currentUser;
    ChatAttachment? localAttachment;
    if (file != null) {
      ///Create a local attachment, type and url will be modify later
      var md5 = await file.lastModified();
      localAttachment = ChatAttachment(
        type: "photo",
        url: "url",
        fileName: file.path,
        fileMd5: md5.millisecondsSinceEpoch.toString(),
      );
    }
    MessageModel messageModel = MessageModel(
      id: "",
      message: message,
      timestamp: DateTime.now().millisecondsSinceEpoch,
      sender: me,
      receiver: room.otherUser,
      room: room.id,
      chatAttachment: localAttachment,
      customData: customData,
      created: nowUtc,
      updated: nowUtc,
    );
    _addNewMessage(messageModel);
    var result = await _messageService.sendMessage(messageModel, file);
    RoomService.instance.updateLastMessageAndUnread(room, result);
    return result;
  }

  Future<void> fetchOlderMessage() async {
    var olderMessages = await _messageService.getOlderMessage(
      oldestMessage: messageManager.data!.last,
      limit: limit,
    );
    hasMoreData = olderMessages.length >= limit;
    messageManager.modifyData((p0) => [...messageManager.data!, ...olderMessages]);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _subscription = null;
    messageManager.dispose();
    super.dispose();
  }
}
