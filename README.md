# currency_exchange

A mobile application which allows you to check the conversion rate of any currencies at real time. The frontend was done using Flutter where as Laravel was used for the backend.


## About Project

This mobile application allows user to check the rate of on currency to another. User can choose any currency from any country and convert it. User may also check their last 10 recent conversions in the history tab as well.

##UI

![Screenshot_1663238984](https://user-images.githubusercontent.com/63856140/190385677-dd99602b-18ed-4437-a860-64d76d1ef3fa.png)

## Functionalities

GET: http://currency-converter.rubai.me/api/currency/get - Get a list of all available currencies for conversion

GET: http://currency-converter.rubai.me/api/recent - Get a list of the last 10 user conversions

GET: http://currency-converter.rubai.me/api/popular - Get a list of top 10 most popular conversions

GET: http://currency-converter.rubai.me/api/currency/search/{keyword} - A api to search currencies based on the input character(s)

GET: https://api.getgeoapi.com/v2/currency/convert?api_key={********}from=INR&to=USD&amount=.92.921,9&format=json - A third party api for real time converstion rate

## Tech Stack

1. Flutter
2. Laravel
3. Postman
4. Intellij CE
5. Visual Studio Code
