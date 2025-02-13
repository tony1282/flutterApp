import 'package:mongo2/models/phone_model.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class MongoService {
  //servicio para conectar con mongodb atlas
  //usando singleton 
  static final MongoService _instance = MongoService._internal();

  MongoService._internal();

  factory MongoService(){
    return _instance;
  }

late mongo.Db _db;

  Future<void> connect() async {
    _db = await mongo.Db.create('mongodb+srv://antonydelacruzramos:Ponyo1ponyo23#@cluster0.e5lb5.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0');
  await _db.open();
  }

  mongo.Db get db {
    if (!db.isConnected){
      throw StateError('bd no inicializada'); 
    }
    return _db;
  }


Future<List<PhoneModel>> getCelulares() async {
  // ignore: non_constant_identifier_names
  final Collection = _db.collection('celulares');
  var phones =  await Collection.find().toList();
  return phones.map((phone) => PhoneModel.fromJson(phone)).toList();

}

  getPhones() {}



}