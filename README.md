# Places

An iOS app that fetches a list of locations from a remote URL and displays them in a list. 
Users can also add their own locations by providing coordinates. 
Selecting a location opens the Wikipedia app on the Places tab for the chosen location.

## Requirements

* Xcode 16+
* Swift 5+
* iOS 16+

## Installation

Clone the repository and open the project:

```
git clone https://github.com/alanxpto/Places.git
cd Places
open Places.xcodeproj
```

## Architecture

The app follows Clean Architecture with MVVM.

The **Domain** layer contains the core entities (`Location`, `LocationResponse`, `LocationsResponse`) and the interfaces that define how location
data is fetched, exposed via `LocationsRepositoryAPI`.

The **Presentation** layer contains the business logic (ViewModels). It fetches data from the domain interfaces, prepares it for presentation, and
exposes observable state to the views.

## UI

The app consists of two main views:

* **LocationsListView**: Displays the list of fetched locations and the locations the user added.
* **InputLocationView**: Allows the user to add a custom location by entering valid coordinates. Valid locations are added to the list.

Tapping a location in the list opens the Wikipedia app on the Places tab for the selected location.

## Testing

Tests can be run directly from Xcode using the `PlacesTests` test target.

## Future Improvements

---
