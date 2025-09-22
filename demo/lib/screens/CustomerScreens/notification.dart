import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with TickerProviderStateMixin {
  // Enhanced notification data with better image URLs and read status
  List<Map<String, dynamic>> notifications = [
    {
      "image": "https://images.unsplash.com/photo-1587049352846-4a222e784d38?w=400",
      "fallbackIcon": Icons.shopping_cart,
      "title": "Your Order#: 999001 from our store has been processed",
      "time": "34 minutes ago",
      "type": "order",
      "isRead": false,
    },
    {
      "image": "https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=400",
      "fallbackIcon": Icons.local_shipping,
      "title": "You have pickup Order#: 998001 in our shop",
      "time": "2 hours ago",
      "type": "pickup",
      "isRead": false,
    },
    {
      "image": "https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?w=400",
      "fallbackIcon": Icons.local_offer,
      "title": "Don't miss a 30% discount for Organic Apple today",
      "time": "4 hours ago",
      "type": "offer",
      "isRead": true,
    },
    {
      "image": "https://images.unsplash.com/photo-1599819177626-6274b2846c81?w=400",
      "fallbackIcon": Icons.shopping_cart,
      "title": "Your Order#: 999001 from our store has been processed",
      "time": "7 hours ago",
      "type": "order",
      "isRead": false,
    },
    {
      "image": "https://images.unsplash.com/photo-1606755962773-d324e01df8b5?w=400",
      "fallbackIcon": Icons.done_all,
      "title": "Order#: 999001 has arrived at your destination",
      "time": "A day ago",
      "type": "delivery",
      "isRead": true,
    },
    {
      "image": "https://images.unsplash.com/photo-1459411621453-7b03977f4bfc?w=400",
      "fallbackIcon": Icons.local_offer,
      "title": "Don't miss a 30% discount for Organic Broccoli today",
      "time": "2 weeks ago",
      "type": "offer",
      "isRead": true,
    },
  ];

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _clearAll() {
    _animationController.forward();
    setState(() {
      notifications.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("All notifications cleared"),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in notifications) {
        notification["isRead"] = true;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("All notifications marked as read"),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Color _getNotificationColor(String type) {
    switch (type) {
      case 'order':
        return Colors.blue.shade50;
      case 'pickup':
        return Colors.orange.shade50;
      case 'offer':
        return Colors.green.shade50;
      case 'delivery':
        return Colors.purple.shade50;
      default:
        return Colors.grey.shade50;
    }
  }

  Color _getTypeIconColor(String type) {
    switch (type) {
      case 'order':
        return Colors.blue;
      case 'pickup':
        return Colors.orange;
      case 'offer':
        return Colors.green;
      case 'delivery':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  Widget _buildNotificationImage(Map<String, dynamic> item) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(11),
        child: Image.network(
          item["image"]!,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              color: _getNotificationColor(item["type"]),
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: _getTypeIconColor(item["type"]),
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) => Container(
            color: _getNotificationColor(item["type"]),
            child: Icon(
              item["fallbackIcon"] ?? Icons.notifications,
              color: _getTypeIconColor(item["type"]),
              size: 28,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final unreadCount = notifications.where((n) => !n["isRead"]).length;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              "Notifications",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            if (unreadCount > 0) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "$unreadCount",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'mark_read') {
                _markAllAsRead();
              } else if (value == 'clear_all') {
                _clearAll();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'mark_read',
                child: Row(
                  children: [
                    Icon(Icons.done_all, size: 20),
                    SizedBox(width: 8),
                    Text('Mark all as read'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'clear_all',
                child: Row(
                  children: [
                    Icon(Icons.clear_all, size: 20),
                    SizedBox(width: 8),
                    Text('Clear all'),
                  ],
                ),
              ),
            ],
          ),
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        shadowColor: Colors.grey.shade300,
      ),
      body: notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_off,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "No notifications 🎉",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "You're all caught up!",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: () async {
                // Simulate refresh
                await Future.delayed(const Duration(seconds: 1));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Notifications refreshed")),
                );
              },
              child: ListView.builder(
                itemCount: notifications.length,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final item = notifications[index];
                  final isRead = item["isRead"] ?? false;
                  
                  return Dismissible(
                    key: Key(item["title"]! + index.toString()),
                    direction: DismissDirection.endToStart,
                    confirmDismiss: (direction) async {
                      return await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Delete Notification"),
                            content: const Text("Are you sure you want to delete this notification?"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(false),
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(true),
                                style: TextButton.styleFrom(foregroundColor: Colors.red),
                                child: const Text("Delete"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    onDismissed: (direction) {
                      setState(() {
                        notifications.removeAt(index);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text("Notification deleted"),
                          action: SnackBarAction(
                            label: "Undo",
                            onPressed: () {
                              setState(() {
                                notifications.insert(index, item);
                              });
                            },
                          ),
                        ),
                      );
                    },
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.delete, color: Colors.white, size: 24),
                          SizedBox(height: 4),
                          Text(
                            "Delete",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: isRead ? Colors.white : _getNotificationColor(item["type"]),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        border: Border.all(
                          color: isRead ? Colors.grey.shade200 : _getTypeIconColor(item["type"]).withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {
                            setState(() {
                              item["isRead"] = true;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Opened: ${item["title"]}"),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                _buildNotificationImage(item),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          if (!isRead)
                                            Container(
                                              width: 8,
                                              height: 8,
                                              margin: const EdgeInsets.only(right: 8),
                                              decoration: BoxDecoration(
                                                color: _getTypeIconColor(item["type"]),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          Expanded(
                                            child: Text(
                                              item["title"]!,
                                              style: TextStyle(
                                                fontWeight: isRead ? FontWeight.w500 : FontWeight.w600,
                                                fontSize: 14,
                                                color: isRead ? Colors.grey.shade700 : Colors.black87,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.access_time,
                                            size: 14,
                                            color: Colors.grey.shade500,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            item["time"]!,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey.shade500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  color: Colors.grey.shade400,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}