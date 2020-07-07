#  Lessons Learned
- While fetching data from a URL is better done in the background, updating the UI might be better in the main thread. The author recommended that, but said it might work even in the background because SwiftUI super smart, but not worth the risk.
# Questions
- Why don't Published properties in an object become Codable if their underlying type is Codable? I understand there is no implementation on Swift part doing that, but it would be very convenient. Is it possible to write an extension to do that?
