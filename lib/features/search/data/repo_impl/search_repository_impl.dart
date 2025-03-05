import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/data/models/user_model.dart';
import '../../../../core/domain/entities/user.dart';
import '../../domain/repo/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final supabase = Supabase.instance.client;
  List<UserEntity> users = [];

  @override
  Future<List<UserEntity>> fetchUsers() async {
    final response = await supabase.from('users').select();
    users = response.map((e) => UserModel.fromMap(e)).toList();
    return users;
  }

  @override
  Future<String?> getChatId(String user1Id, String user2Id) async {
    final response = await supabase
        .from('chats')
        .select()
        .or('and(user1_id.eq.$user1Id,user2_id.eq.$user2Id),and(user1_id.eq.$user2Id,user2_id.eq.$user1Id)')
        .maybeSingle();
    if (response != null) {
      return response['chat_id'];
    }
    return null;
  }
}
