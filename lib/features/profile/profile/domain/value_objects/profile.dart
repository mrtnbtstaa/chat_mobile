import 'dart:io';
import 'package:mime/mime.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/errors/profile_failure.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

@immutable
class Profile extends Equatable {

  final File file;

  // Private constructor
  const Profile._(this.file);
  
  static Future<Either<Failure, Profile>> create({
    required File file,
    required double maxMb,
    required List<String> allowedExtensions
  }) async {

    // Limit MB
    final sizeInMb = file.lengthSync() / (1024 * 1024);
    if(sizeInMb > maxMb){
      return left(ProfileMBFailure("File too large: ${sizeInMb.toStringAsFixed(2)}MB"));
    }

    // Extension validation
    final extension = file.path.split(".").last.toLowerCase();
    if(!allowedExtensions.contains(extension)){
      return left(ProfileExtensionFailure("Invalid extension: $extension"));
    }

    // Content validation (HEADER + MIME)
    // Read only the first 12 bytes to avoid loading the whole file into memory
    final headerBytes = await file.openRead(0, 12).first;
    if (!_isValidImage(headerBytes, file.path)) {
      return left(ProfileContentValidationFailure("File content is not a valid image"));
    }

    return right(Profile._(file));

  }

  static bool _isValidImage(List<int> bytes, String path) {
  if (bytes.length < 4) return false;

  // JPEG (FF D8 FF)
  if (bytes[0] == 0xFF && bytes[1] == 0xD8 && bytes[2] == 0xFF) return true;

  // PNG (89 50 4E 47)
  if (bytes[0] == 0x89 && bytes[1] == 0x50 && bytes[2] == 0x4E && bytes[3] == 0x47) return true;

  // HEIC Check (ftypheic)
  if (bytes.length >= 12) {
    final brand = String.fromCharCodes(bytes.sublist(4, 8));
    if (brand == 'ftyp') {
      final subBrand = String.fromCharCodes(bytes.sublist(8, 12));
      if (subBrand == 'heic' || subBrand == 'mif1') return true;
    }
  }

  // Backup check using the 'mime' package
  final mimeType = lookupMimeType(path, headerBytes: bytes);
  return mimeType != null && mimeType.startsWith('image/');
}

  @override
  List<Object?> get props => [file];

}