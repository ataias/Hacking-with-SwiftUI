#  Lessons Learned

- You can show alerts and sheets using an optional object instead of a boolean. From inside the alert or sheet you can then get the value directly and it is set back to nil onDismiss
- You can use 'Group' to group elements without specifying the layout. When you wrap them in a VStack or HStack they will be oriented accordingly.
- Using Groups, you can apply a modifier to multiple views more easily as well
- ListFormatter can joins strings using a more natural combination when compared to `joined(separator:)`. For a list like `["A", "B", "C"]` we would get `A, B, C` with `joined(separator:)` and `A, B, and C` with `ListFormatter`
- A `Spacer().frame(height=0)` will have flexible `width` which by default takes all available space. If you have it in combination with other spacers you may not see the same spacing between all the elements. To fix it, you need to make all have a flexible `width` (which takes all available space by default) so that they even out.
- Sometimes you may see text wrapping over 2 lines when they are in an `HStack` with spacers. The spacer ends up taking the priority in the layout. To fix it, you should add `layoutPriority(1)` to your text elements.
