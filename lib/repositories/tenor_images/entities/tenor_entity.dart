class TenorEntity {
  final String id;
  final String preview;
  final String url;

  TenorEntity({required this.id, required this.preview, required this.url});

  factory TenorEntity.fromJson(Map<String, dynamic> json) {
    return TenorEntity(
        id: json['results'][0]['id'],
        preview: json['results'][0]['id'],
        url: json['results'][0]['media_formats']['tinygif']['url']);
  }

  TenorEntity.empty()
      : id = '',
        preview = '',
        url = '';
}
