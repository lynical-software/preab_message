import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:preab_message/preab_message.dart';
import 'package:preab_message/src/model/model_extension.dart';
import 'package:skadi_firebase/skadi_firebase.dart';

class RoomService extends FirestoreCollectionService {
  RoomService._privateConstructor();

  static final RoomService instance = RoomService._privateConstructor();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  String get tableName => PreabSetting.instance.roomCollection;

  final List<RoomModel> rooms = [];
  ChatUser get _me => PreabSetting.instance.currentUser;

  ///Room list stream
  Stream<List<RoomModel>> get getRoomStream {
    return collection
        .where(
          RoomModel.userIdsKey,
          arrayContains: _auth.currentUser?.uid,
        )
        .orderBy("last_message.timestamp", descending: true)
        .snapshots()
        .map((event) {
      rooms.clear();
      rooms.addAll(event.docs.map((e) => RoomModel.fromJson(e.data())).toList());
      rooms.sort((a, b) => b.lastMessage!.timestamp.compareTo(a.lastMessage!.timestamp));
      return rooms;
    });
  }

  ///Query all your chat room
  Future<List<RoomModel>> getAllMyRooms(String userId) async {
    var result = await collection
        .where(
          RoomModel.userIdsKey,
          arrayContains: userId,
        )
        .get();
    return result.docs.map((e) => RoomModel.fromJson(e.data())).toList();
  }

  ///Create chat room page and return a Room model
  ///return a room if Exist
  Future<RoomModel> createRoom(ChatUser otherUser) async {
    final myRooms = await getAllMyRooms(_me.uid);
    RoomModel? existingRoom;
    for (var room in myRooms) {
      var found = room.userIds.contains(_me.uid) && room.userIds.contains(otherUser.uid);
      if (found) {
        existingRoom = room;
        break;
      }
    }
    if (existingRoom != null) {
      return existingRoom;
    }

    List<ChatUser> users = [_me, otherUser];
    RoomModel roomModel = RoomModel(
      id: "",
      lastMessage: LastMessage(
        message: "${_me.username} create a chat room",
        sender: _me.uid,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      ),
      users: users,
      userIds: users.map((e) => e.uid).toList(),
      unread: {otherUser.uid: 1, _me.uid: 0},
      created: now,
      updated: now,
    );
    final docId = await createDocument(roomModel.toJson());
    return roomModel.copyWith(id: docId);
  }

  ///Update room information when user navigate into chat room page
  Future<void> updateRoomsUserInfo(RoomModel room, ChatUser otherUser) async {
    collection.doc(room.id).update({
      RoomModel.usersKey: [PreabSetting.instance.currentUser.toJson(), otherUser.toJson()]
    });
  }

  Future<RoomModel> getOneRoom(String roomId) async {
    final data = await collection.doc(roomId).get();
    if (!data.exists) {
      throw "Room doesn't exisit";
    }
    return RoomModel.fromJson(data.data()!);
  }

  void clearMyUnread(String roomId) {
    collection.doc(roomId).set({
      RoomModel.unreadKey: {
        _me.uid: 0,
      }
    }, SetOptions(merge: true));
  }

  void updateLastMessageAndUnread(RoomModel room, MessageModel message) async {
    collection.doc(room.id).set({
      "unread": {
        room.otherUser.uid: FieldValue.increment(1),
      },
      "last_message": LastMessage(
        sender: message.sender!.uid,
        message: message.chatAttachment != null ? message.chatAttachment!.type : message.message,
        timestamp: message.timestamp,
      ).toJson(),
    }, SetOptions(merge: true)).catchError((err) {
      debugPrint(err.toString());
    });
  }
}
