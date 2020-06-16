# Lessons Learned
- Image resizing: fit vs fill
- ScrollViews are more generic than List and Form for scrolling. One catch when
  using them: they use eager evaluation instead of lazy evaluation in the list
  view.
- NavigationLink and sheet() serve difference purposes, as stated by @twostraws:
  - NavigationLink is for showing details about the user’s selection, like
    you’re digging deeper into a topic.
  - sheet() is for showing unrelated content, such as settings or a compose
    window.
- I analyze his statement looking at the "Bear" app and it was right on the
  mark.
