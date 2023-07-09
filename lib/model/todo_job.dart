class TodoJob {
  final String text;
  final DateTime? deadline;
  final bool done;

  TodoJob({required this.text, this.deadline, this.done = false});

  TodoJob copyWith({
    String? text,
    DateTime? deadline,
    bool? done,
  }) {
    return TodoJob(
      text: text ?? this.text,
      deadline: deadline ?? this.deadline,
      done: done ?? this.done,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoJob &&
          runtimeType == other.runtimeType &&
          text == other.text &&
          deadline == other.deadline &&
          done == other.done;

  @override
  int get hashCode => text.hashCode ^ deadline.hashCode ^ done.hashCode;

  factory TodoJob.fromJson(Map<String, dynamic> jsonData) {
    return TodoJob(
      text: jsonData['text'],
      done: jsonData['done'] ,
      deadline: jsonData['deadline'] == null ? null : DateTime.parse(jsonData['deadline']) ,
    );
  }

  static Map<String, dynamic> toJson(TodoJob todoJob) => {
        'text': todoJob.text,
        'deadline': todoJob.deadline?.toIso8601String(),
        'done': todoJob.done
      };
}
