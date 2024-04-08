import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class ChatService {
  //get instance of chat service
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /*
List<Map<String,dynamic>> = [
  {
    'email': 'test@gmail.com',
    'id': ....,

},
{
    'email': 'tahaknkl@gmail.com',
    'id': ....,


*/

  //get user stream
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection('Users').snapshots().map((snapshot) => snapshot.docs.map((doc) {
          //go toeach individual user
          final user = doc.data();

          //return user
          return user;
        }).toList());
  }

  //send message
  Future<void> sendMessage({required MessageModel message}) async {
    final uid = const Uuid().v4();
    message.uid = uid;
    message.senderUid = _auth.currentUser!.uid;

    await _firestore.collection("Users").doc(message.senderUid).collection("chats").doc(message.uid).set(message.toMap());
    await _firestore.collection("Users").doc(message.recieverUid).collection("chats").doc(message.uid).set(message.toMap());
  }

  //send message


  //get messages
  //burda şunu yapıyoruz ki bizim mesajlarımızı alıyoruz ve bunları bir stream olarak döndürüyoruz ki bu streami dinleyen widgetlerde bu mesajları gösterebilelim
  Stream<List<MessageModel>> getMessages({required String receiverUid}) {
    return _firestore.collection("Users").doc(_auth.currentUser!.uid).collection("chats").snapshots().map((snapshot) => snapshot.docs.map((doc) {
          final message = MessageModel.fromMap(doc.data());
          return message;
        }).toList());
  }
}
