# Crypto Tracker V1

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

## Overview
Here's a walkthrough  of implemented features:

### Features

- [] User sees a list of top cryptocurrencies as soon as the app opens.
    - [] Each coin displays name, symbol, current price, and 24h price change.
    - [] User can tap any coin to navigate to a details page.

- [] On the details page, user can see additional information about the selected coin:
    - [] Price chart or simple price trend indicator (24h/7d)
    - [] Market cap, volume, and circulating supply
    - [] Short description and external website link

- [] User can add or remove coins from their **Watchlist** by tapping a star button.
    - [] Watchlist selections are saved using `UserDefaults` and persist across app launches.

- [] On the **Watchlist** page, user sees only the coins they have favorited.
    - [] User can tap a coin in the Watchlist to view its details again.

- [] The app uses a **Tab Bar** for navigation:
    - **Market** (All coins)
    - **Watchlist** (Favorited coins)
    - **Learn** (Educational/overview page about crypto basics)

### Description

This app uses the CoinGecko API to display real-time cryptocurrency market data. Users can browse the top coins, view detailed price information, and save their favorite cryptocurrencies to a personal Watchlist for quick access. The app also provides a simple overview page to help users learn core crypto concepts.

### App Evaluation

### 1. Crypto Tracker
- **Description:** A real-time cryptocurrency tracking app that allows users to monitor coin prices, view market trends, and create personalized watchlists. Users can also explore basic explanations of each coin to better understand the crypto ecosystem.
- **Category:** Finance / Education  
- **Mobile:** Mobile-first experience enables quick price checks, push notifications for market changes, and glanceable dashboards. Interactive charts and widgets are optimized for on-the-go use.
- **Story:** Designed to make the crypto world easier to understand, especially for beginners who may feel overwhelmed by complex trading platforms. Helps users stay informed without needing to actively invest.
- **Market:** Perfect for crypto newcomers, students, casual traders, and anyone curious about digital currencies. Can also appeal to hobby investors who want a simple, informative interface.
- **Habit:** Encourages frequent checking—crypto markets move constantly, so users may open the app daily or even hourly. Notifications, watchlists, and trending coins strengthen habit loops.
- **Scope:**  
  - **V1:** Basic watchlist + live price data + simple coin details.  
  - **V2:** Price alerts, market news integration, and coin comparison tools.  
  - **V3:** Portfolio simulation, community discussions, challenges, and learning modules.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* As a user, I want to see a list of the top cryptocurrencies when I open the app.
* As a user, I want to tap on a coin to view more detailed information about it.
* As a user, I want to add or remove coins from my Watchlist.
* As a user, I want my Watchlist to persist even after closing and reopening the app (using UserDefaults).
* As a user, I want to view my saved (favorited) coins in a dedicated Watchlist tab.
* As a user, I want the app to load quickly and have a clean, simple UI that is easy to navigate.

**Optional Nice-to-have Stories (Future Implementation)**

* As a user, I want to search for a specific cryptocurrency by name or symbol.
* As a user, I want to see a historical price chart of each cryptocurrency.
* As a user, I want to receive price alerts when a coin changes above or below a chosen threshold.
* As a user, I want to switch between currencies (USD, EUR, etc.).
* As a user, I want to sort and filter coins (e.g., top gainers, top losers, highest market cap).
* As a user, I want to share coin data or price updates with others through messaging or social apps.


### 2. Screen Archetypes

**Market View (Home)**
* As a user, I want to see a list of top cryptocurrencies with price and 24h change as soon as I open the app.
* As a user, I want to tap on a coin to view more details about it.

**Coin Details View**
* As a user, I want to see more in-depth information about the selected cryptocurrency (price, market cap, volume, description).
* As a user, I want to add or remove the coin from my Watchlist using a favorite/star button.
* As a user, I want the option to open the coin’s official website or external resources for more info.

**Watchlist View**
* As a user, I want to see a list of the cryptocurrencies I have marked as favorites.
* As a user, I want this list to update automatically when I add or remove coins.
* As a user, I want my watchlist to persist when I close or reopen the app.

**Learn / Info View (optional third tab)**
* As a user, I want to see basic explanations about cryptocurrency concepts (e.g., market cap, blockchain, how wallets work).
* As a user, I want this section to be simple and easy to understand.


### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Market (List of all coins)
* Watchlist (User's favorited coins)
* Learn (Basic crypto info / glossary)

**Flow Navigation** (Screen to Screen)

**Market View**
* Tap a coin to navigate to **Coin Details View**
* Tap Watchlist tab to navigate to **Watchlist View**
* Tap Learn tab to navigate to **Learn View**

**Coin Details View**
* Tap star button to add/remove from Watchlist
* Tap Market tab to return to **Market View**
* Tap Watchlist tab to go to the **Watchlist View**
* Tap Learn tab to go to the **Learn View**

**Watchlist View**
* Tap a coin to navigate to **Coin Details View**
* Tap Market tab to navigate to **Market View**
* Tap Learn tab to navigate to **Learn View**

**Learn View**
* Tap Market tab to navigate back to **Market View**
* Tap Watchlist tab to navigate to **Watchlist View**

## Wireframes
<img src="./sc1.png" width=300>

<img src="./sc2.png" width=300>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 


### Models

[Add table of models]

### Networking

-API: `[https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd]`
