#  Lessons Learned

- You can show alerts and sheets using an optional object instead of a boolean. From inside the alert or sheet you can then get the value directly and it is set back to nil onDismiss
- You can use 'Group' to group elements without specifying the layout. When you wrap them in a VStack or HStack they will be oriented accordingly.
