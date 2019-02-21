# Monzo Client for macOS
This is a client that shows your monzo transactions on macOS using monzo's developer API.

**NOTE** - This project is not in any way associated with Monzo itself, it is just a personal project!

## Getting Started

To get the app running showing your own monzo transactions:
* Head over to monzo's [developer playground](https://developers.monzo.com) and sign in using your monzo account
* After logging in you should be directed to the API Playground where your Account Id & Access Token should be displayed
* Clone this repo & open in Xcode
* Open the AccountInfo class, and copy & paste the relevent info into accountId and accessToken values
* Build :100:

## Future Improvements

This project is a work in progress, so there are lots of things i'd like to improve:

* Tests - :dancer:
* Pots - the developer API allows interaction with pots, so I'll add a separate pots view soon
* Notes - although i don't personally use notes on transactions much, I want to add functionality to add notes to transactions from the client as the API supports it, as well as attachements and the new Reciepts API
* Currencies - currently only deals with £
* Search - The monzo app currently has a search functionality for transactions which i'd like to implement
* Infinite Scroll - I'd quite like to make use of the optional paginated API responses to reduce the heavy network request for all transactions from a certain date
* OAuth - the API does support user authentication, however it requires a redirect URL for a personal domain which i would need to set up
