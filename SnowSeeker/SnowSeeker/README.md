#  Lessons Learned

- You can show alerts and sheets using an optional object instead of a boolean. From inside the alert or sheet you can then get the value directly and it is set back to nil onDismiss
- You can use 'Group' to group elements without specifying the layout. When you wrap them in a VStack or HStack they will be oriented accordingly.
- Using Groups, you can apply a modifier to multiple views more easily as well
- ListFormatter can joins strings using a more natural combination when compared to `joined(separator:)`. For a list like `["A", "B", "C"]` we would get `A, B, C` with `joined(separator:)` and `A, B, and C` with `ListFormatter`
