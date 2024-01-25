// To parse this JSON data, do
//
//     final blog = blogFromJson(jsonString);

import 'dart:convert';

Blog blogFromJson(String str) => Blog.fromJson(json.decode(str));

String blogToJson(Blog data) => json.encode(data.toJson());

class Blog {
  int? id;
  String? title;
  dynamic image;
  String? description;
  int? companyId;
  DateTime? dateEn;
  DateTime? dateNp;
  String? status;
  int? createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  Blog({
    this.id,
    this.title,
    this.image,
    this.description,
    this.companyId,
    this.dateEn,
    this.dateNp,
    this.status,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        description: json["description"],
        companyId: json["company_id"],
        dateEn:
            json["date_en"] == null ? null : DateTime.parse(json["date_en"]),
        dateNp:
            json["date_np"] == null ? null : DateTime.parse(json["date_np"]),
        status: json["status"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        deletedBy: json["deleted_by"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "description": description,
        "company_id": companyId,
        "date_en":
            "${dateEn!.year.toString().padLeft(4, '0')}-${dateEn!.month.toString().padLeft(2, '0')}-${dateEn!.day.toString().padLeft(2, '0')}",
        "date_np":
            "${dateNp!.year.toString().padLeft(4, '0')}-${dateNp!.month.toString().padLeft(2, '0')}-${dateNp!.day.toString().padLeft(2, '0')}",
        "status": status,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "deleted_by": deletedBy,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
