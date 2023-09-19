import 'package:flutter/material.dart';
import 'package:preab_message/preab_message.dart';
import 'package:preab_message/src/type/types.dart';

class PreabSetting {
  PreabSetting._privateConstructor();

  static final PreabSetting instance = PreabSetting._privateConstructor();

  String? _messageCollection;
  bool _initialize = false;

  String get messageCollection {
    assert(_messageCollection != null);
    _initCheck();
    return _messageCollection!;
  }

  String? _roomCollection;

  String get roomCollection {
    assert(_roomCollection != null);
    _initCheck();
    return _roomCollection!;
  }

  String? _storagePath;

  String get storagePath {
    assert(_storagePath != null);
    _initCheck();
    return _storagePath!;
  }

  ////Current user
  ChatUser? _currentUser;

  ChatUser get currentUser {
    assert(_currentUser != null);
    _initCheck();
    return _currentUser!;
  }

  set currentUser(ChatUser currentUser) {
    _currentUser = currentUser;
  }

  ////Json from mapper
  UserFromJsonMapper? _userJsonMapper;

  UserFromJsonMapper get userJsonMapper {
    assert(_userJsonMapper != null);
    _initCheck();
    return _userJsonMapper!;
  }

  set userJsonMapper(UserFromJsonMapper userJsonMapper) {
    _userJsonMapper = userJsonMapper;
  }

  ////Json to mapper
  UserToJsonMapper? _userToJsonMapper;

  UserToJsonMapper get userToJsonMapper {
    assert(_userToJsonMapper != null);
    _initCheck();
    return _userToJsonMapper!;
  }

  set userToJsonMapper(UserToJsonMapper userToJsonMapper) {
    _userToJsonMapper = userToJsonMapper;
  }

  void _initCheck() {
    if (!_initialize) {
      throw FlutterError("Please initialize PreabSetting with PreabSetting.instance.init()");
    }
  }

  void init({
    required ChatUser currentUser,
    required UserFromJsonMapper userJsonMapper,
    required UserToJsonMapper userToJsonMapper,
    String roomCollection = "rooms",
    String messageCollection = "messages",
    String storagePath = "/storage",
  }) {
    _messageCollection = messageCollection;
    _userJsonMapper = userJsonMapper;
    _userToJsonMapper = userToJsonMapper;
    _roomCollection = roomCollection;
    _currentUser = currentUser;
    _storagePath = storagePath;
    _initialize = true;
  }
}
