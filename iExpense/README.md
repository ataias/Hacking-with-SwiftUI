# Lessons Learned
- Adding items and removing them from a list can be quite easy, requiring very
  little code
- Multi-view apps with sheets are also very simple.

# Next Steps
- Bugs in SwiftUI code are hard to catch. There is one I couldn't find any clues
  in a reasonable time: the add button is not triggered. The first time it
  works, but afterwards it works once every three clicks or never until you
  restart the app. I imagine it might be a bug in SwiftUI navigation bar
  items... but who knows. I tried checking my code to no avail. This is
  something that needs to be tested in the future and maybe investigate the code
  more if newer versions still behave the same.
