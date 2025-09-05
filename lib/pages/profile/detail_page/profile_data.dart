import 'package:flutter/material.dart';
import 'package:torrid/services/hive_service.dart';

class ProfileData extends StatefulWidget {
  const ProfileData({super.key});

  @override
  State<ProfileData> createState() => _ProfileDataState();
}

class _ProfileDataState extends State<ProfileData> {
  bool isLoading = false;

  Future<void> loadWithFunc(Future<void> func) async {
    setState(() {
      isLoading = true;
    });
    await func;
    setState(() {
      isLoading = false;
    });
  }

  // 显示确认对话框
  Future<void> showConfirmationDialog(
    String actionText, 
    Future<void> Function() action
  ) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('确认操作'),
        content: Text('确定$actionText吗'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('确定'),
          ),
        ],
      ),
    );

    if (result == true) {
      await loadWithFunc(action());
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      theme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "请勿退出或关闭应用...",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 同步相关操作
                  Text(
                    "同步到本地:",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildActionButton(
                    context: context,
                    icon: Icons.check_circle,
                    label: "同步打卡",
                    action: HiveService.syncBooklet,
                  ),
                  const SizedBox(height: 8),
                  _buildActionButton(
                    context: context,
                    icon: Icons.note,
                    label: "同步随笔",
                    action: HiveService.syncEssay,
                  ),

                  const SizedBox(height: 24),

                  // 更新相关操作
                  Text(
                    "更新到外部:",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildActionButton(
                    context: context,
                    icon: Icons.upload_file,
                    label: "更新打卡",
                    action: HiveService.updateBooklet,
                  ),
                  const SizedBox(height: 8),
                  _buildActionButton(
                    context: context,
                    icon: Icons.upload,
                    label: "更新随笔",
                    action: HiveService.updateEssay,
                  ),
                ],
              ),
            ),
    );
  }

  // 构建带样式的操作按钮
  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Future<void> Function() action,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TextButton.icon(
        onPressed: () => showConfirmationDialog(label, action),
        icon: Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
        ),
        label: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
          ),
        ),
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          minimumSize: const Size(double.infinity, 50),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }
}
