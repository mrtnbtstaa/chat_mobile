import 'package:fpdart/fpdart.dart';
import '../../../../../core/errors/failure.dart';
import '../entities/paginated_group_member.dart';

abstract interface class IGroupMemberRepository {
  Future<Either<Failure, PaginatedGroupMember>> getMembers(String? cursorUrl);
}