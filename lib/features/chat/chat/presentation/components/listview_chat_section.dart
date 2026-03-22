import 'package:chat/core/di/di.dart';
import 'package:chat/core/style/app_insets.dart';
import 'package:chat/core/usecases/base_usecase.dart';
import 'package:chat/core/utils/shared_preferences_manager.dart';
import 'package:chat/features/chat/chat/application/bloc/chat_bloc.dart';
import 'package:chat/features/chat/chat/domain/entities/chat_entity.dart';
import 'package:chat/features/chat/chat/domain/params/user_id_param.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'chat_item.dart';

class ListviewChatSection extends StatelessWidget {

  const ListviewChatSection({ 
    super.key
  });

  @override
  Widget build(BuildContext context){
    final chatBloc = context.read<ChatBloc>();
    return Expanded(
      child: Padding(
        padding: AppInsets.v4,
        child: FutureBuilder(
          future: sl<BaseUsecase<List<ChatEntity>, UserIdParam>>().call(UserIdParam(userId: SharedPreferencesManager.instance?.getString("user_id") ?? "")),
          builder:(context, index) {
            return ChatItem();
          },
        ),
      )
    );
  }
}