#  Lessons Learned
- Using a direct binding allows us to have custom "didSets", which in turn can be used to set UserDefaults or CoreData (no need for ObservableObjects in this case)
- CIFilter.pixellate did not work for me initially. It has just shown a blank image. I thought it was broken but then I reduced the scale and I managed to see an actual image.

# Problems
- CIFilter.crystallize was broken in both scenarios
