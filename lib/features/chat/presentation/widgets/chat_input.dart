import 'package:flutter/material.dart';
import '../../../../core/utils/utils.dart';

class ChatInput extends StatefulWidget {
  final Function(String) onSend;
  final Function()? onAttachment;

  const ChatInput({
    super.key,
    required this.onSend,
    this.onAttachment,
  });

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final _controller = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() => _hasText = _controller.text.isNotEmpty);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 8.h,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.backgroundLight,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.neutral800 : AppColors.neutral200,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                EneftyIcons.image_outline,
                color: AppColors.primary500,
                size: 24.sp,
              ),
              onPressed: widget.onAttachment,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: TextField(
                controller: _controller,
                maxLines: 4,
                minLines: 1,
                textCapitalization: TextCapitalization.sentences,
                style: TextStyle(fontSize: 16.sp),
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: TextStyle(
                    color: AppColors.neutral400,
                    fontSize: 16.sp,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: IconButton(
                icon: Icon(
                  _hasText
                      ? EneftyIcons.send_2_bold
                      : EneftyIcons.send_2_outline,
                  color: _hasText ? AppColors.primary500 : AppColors.neutral400,
                  size: 24.sp,
                ),
                onPressed: _hasText
                    ? () {
                        widget.onSend(_controller.text);
                        _controller.clear();
                      }
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
