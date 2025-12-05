# TON Connect Wallets

List of wallets that support [TON Connect](https://docs.ton.org/ecosystem/ton-connect/overview).

The [TON Connect SDK](https://github.com/ton-connect/sdk) uses this list to show available wallets in dApps.

## For Wallet Developers

Want to integrate TON Connect into your wallet?

> **[WalletKit](https://docs.ton.org/ecosystem/ton-connect/walletkit/overview)** — recommended SDK that handles connection flows, signing, and session management out of the box.

Or implement the [TON Connect protocol](https://github.com/ton-blockchain/ton-connect) directly if you need full control.

### How to Add Your Wallet

1. Implement TON Connect using [WalletKit](https://docs.ton.org/ecosystem/ton-connect/walletkit/overview) or the [protocol spec](https://github.com/ton-blockchain/ton-connect)
2. Submit a [pull request](https://github.com/ton-connect/wallets-list/pulls) adding your wallet **to the end of the list**
3. We'll review and merge promptly

### Entry format

Each entry has the following format (subject to change):

```json
{
  "app_name": "tonkeeper",
  "name": "Tonkeeper",
  "image": "https://tonkeeper.com/assets/tonconnect-icon.png",
  "tondns":  "tonkeeper.ton",
  "about_url": "https://tonkeeper.com",
  "universal_url": "https://app.tonkeeper.com/ton-connect",
  "bridge": [ 
     {
        "type": "sse",
        "url": "https://connect.ton.org/bridge"
     },
     {
        "type": "js",
        "key": "tonkeeper"
     }
  ],
  "platforms": ["ios", "android", "chrome", "firefox", "safari", "windows", "macos", "linux"],
  "features": [
    {
      "name": "SendTransaction",
      "maxMessages": 4,
      "extraCurrencySupported": false
    },
    {
      "name": "SignData",
      "types": ["text", "binary", "cell"]
    }
  ]
}
```

#### Description
- `app_name`: string ID of your wallet. Must be equal with `ConnectEventSuccess.device.appName` and js bridge `key`
- `name`: name of your wallet. Will be displayed in the dapp.
- `image`: url to the icon of your wallet. Will be displayed in the dapp. Resolution 288×288px. On non-transparent background, without rounded corners. PNG format. Please, use OptinPNG (pngquan/ImageMagick/TinyPNG) to reduce bandwidth.
- `tondns`: (optional) will be used in the protocol later.
- `about_url`: info or landing page of your wallet. May be useful for TON newcomers.
- `universal_url`: (strictly required for `sse` bridges, optional otherwise) base part of your wallet universal url. Your link should support [Ton Connect parameters](https://github.com/ton-connect/docs/blob/main/bridge.md#universal-link)
- `bridge`: options for connectivity between the app and the wallet
    - `type="sse"`: specify the `url` of your wallet's implementation of the [HTTP bridge](https://github.com/ton-connect/docs/blob/main/bridge.md#http-bridge).
    - `type="js"`: specify the `key` through which your wallet handles [JS Bridge](https://github.com/ton-connect/docs/blob/main/bridge.md#js-bridge) connection, specify the binding for your bridge object accessible through `window`. Example: the key `"tonkeeper"` means the bridge can be accessed as `window.tonkeeper`.
- `platforms`: list of platforms on which your wallet works: mobile app "ios", "android"; desktop app "windows", "macos", "linux"; browser extension "chrome", "firefox", "safari".
- `features`: list of supported TON Connect features and their capabilities:
    - `SendTransaction`: Transaction sending capability
        - `maxMessages`: maximum number of messages in one transaction (typically 4 or 255)
        - `extraCurrencySupported`: (optional, `false` by default) whether wallet supports extra currencies
    - `SignData`: Data signing capability  
        - `types`: array of supported data types for signing: `"text"`, `"binary"`, `"cell"`

If your wallet supports HTTP Bridge, you should specify `universal_url` and `bridge.type="sse"`.

If your wallet provides the JS bridge (e.g. as a browser extension), you should specify the `bridge.type="js"`.

If your wallet supports both bridges, you have to specify `universal_url` and both `bridge.type="sse"` and `bridge.type="js"`.

### What is the policy?

Our goal is to represent accurate up-to-date list of all TON wallets that support TON Connect.

In the future it would be a good idea to replicate wallet's info in a TON DNS record so that this repo simply lists the wallet domain names (to filter out spam), while developers have more direct control over the wallet parameters.
