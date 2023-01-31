import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skadi_firebase/skadi_firebase.dart';

import '../../preab_message.dart';

class MessageService with FirestoreCollectionService {
  final String roomId;

  @override
  String get tableName => PreabSetting.instance.messageCollection;
  MessageService(this.roomId);

  Stream<MessageModel?> get recentMessageStream {
    return collection
        .where(MessageModel.roomKey, isEqualTo: roomId)
        .orderBy(
          MessageModel.timestampKey,
          descending: true,
        )
        .limit(1)
        .snapshots()
        .map(
      (event) {
        var data = event.docs;
        var messages = data.map((e) => MessageModel.fromJson(e.data())).toList();
        return messages.isNotEmpty ? messages.first : null;
      },
    );
  }

  Future<List<MessageModel>> getInitialMessage({
    int limit = 20,
  }) async {
    return collection
        .where(MessageModel.roomKey, isEqualTo: roomId)
        .orderBy(
          MessageModel.timestampKey,
          descending: true,
        )
        .limit(limit)
        .get()
        .then(
      (event) {
        var data = event.docs;
        var messages = data.map((e) => MessageModel.fromJson(e.data())).toList();
        if (messages.length == 1 && messages.first.message.isEmpty && messages.first.chatAttachment == null) {
          return [];
        }
        return messages;
      },
    );
  }

  Future<List<MessageModel>> getOlderMessage({
    required MessageModel? oldestMessage,
    int limit = 20,
  }) async {
    DocumentSnapshot<Map<String, dynamic>>? lastDoc;
    if (oldestMessage != null) {
      lastDoc = await collection.doc(oldestMessage.id).get();
    }
    var query = collection
        .where(MessageModel.roomKey, isEqualTo: roomId)
        .orderBy(
          MessageModel.timestampKey,
          descending: true,
        )
        .limit(limit);
    if (lastDoc != null) {
      query = query.startAfterDocument(lastDoc);
    }
    return query.get().then(
      (event) {
        var data = event.docs;
        var messages = data.map((e) => MessageModel.fromJson(e.data())).toList();
        return messages;
      },
    );
  }

  Future<MessageModel> sendMessage(MessageModel messageModel, File? file) async {
    if (file != null) {
      String fileName = file.uri.pathSegments.last;
      String url = await PreabFirebaseStorage.uploadImageFile(file, fileName);
      messageModel = messageModel.copyWith(
        chatAttachment: ChatAttachment(
          url: url,
          type: messageModel.chatAttachment!.type,
          fileName: messageModel.chatAttachment!.fileName,
        ),
      );
    }
    var docId = await createDocument(messageModel.toJson());
    return messageModel.copyWith(id: docId);
  }
}
