import 'package:chat/features/chat/chat_group/models/entities/paginated_group_member.dart';
import 'group_chat_result_response_dto.dart';

class PaginatedGroupChatResponseDto extends PaginatedGroupMember {

  const PaginatedGroupChatResponseDto({
    super.next,
    super.previous,
    required super.results
  });

  factory PaginatedGroupChatResponseDto.fromJson(Map<String, dynamic> json){  
    return PaginatedGroupChatResponseDto(
      next: json["next"],
      previous: json["previous"],
      results: (json["results"] as List? ?? []).map((member) => GroupChatResultResponseDto.fromJson(member)).toList()
    );
  }

  PaginatedGroupMember toEntity() => this;

}

