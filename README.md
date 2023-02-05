# Photos search APP using Flickr API.

## Tools:
- Xcode 14.2.
- Swift 5.
- No External Framework or tools needed.

## Architecture:
- Combine.
- SwiftUI.
- Core components with protocols, to open usage for extension, can be extended to use with other APIs and Media types.


## Features:
- Search.
- Search suggestions based on user history
- Images Caching.
- Pagination.
- Handling no results found. 
- Light mode and dark mode supported and tested.
- Unit tests.


## Future improvements:
- Implement a better way of caching images.
- Give a way to user to clear history.
- Better error handling
    - Flickr error codes.
    - Error messages to user.
    - Option to retry.
- Implement a full Network layer with instead of relaying only on URLSession.
- Add moe unit tests:
     - The current unit tests onluy acts as a POC of how the architecture separates components and enables testability for them.
     
