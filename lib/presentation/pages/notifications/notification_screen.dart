import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:readmock/presentation/widgets/custom_scaffold.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key);

  // Sample data for notifications
  final List<Map<String, dynamic>> notifications = List.generate(10, (index) {
    return {
      'title': 'Notification ${index + 1}',
      'description': 'This is the description for notification ${index + 1}.',
      'timestamp': DateTime.now().subtract(Duration(days: index)),
      'read': index % 3 == 0 // Mark every third notification as read
    };
  });

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return ListTile(
            leading: CircleAvatar(
              child: Icon(
                notification['read']
                    ? Icons.mark_email_read
                    : Icons.mark_email_unread,
                color: Colors.white,
              ),
              backgroundColor: notification['read'] ? Colors.green : Colors.red,
            ),
            title: Text(
              notification['title'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: notification['read'] ? Colors.black45 : Colors.black,
              ),
            ),
            subtitle: Text(
              notification['description'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Text(
              DateFormat('dd/MM/yyyy').format(notification['timestamp']),
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            onTap: () {
              // Implement navigation to notification detail or mark as read
            },
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            tileColor: notification['read'] ? Colors.white : Colors.yellow[100],
          );
        },
      ),
    );
  }
}
