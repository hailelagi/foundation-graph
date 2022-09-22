# Fnd

View NFTs from the Foundation.app marketplace via The Graph.

## Architecture

Fnd is phoenix server with a react.js frontend.

The core operations are performed by two `GenServer`'s in `fnd/worker`, a cache which periodically fetches nft data from theGraph via the `Fnd.Graph` graphQL client and stores them in the database. A second worker resolver periodically queries the database if it has any new metadata and resolves its content hash via `Fnd.Ipfs` a small http client.

The period chosen is arbitrary, the cache warms exponentially every few minutes, not to drain the GRT balance on the graph too quickly and the resolver linearly every three minutes.

It is then fetched from the database every 10 second and resolved via ipfs to display an image.

## caveats/limitations

- rate limiting via client ip address and wallet address, The Graph queries cost a pretty penny!

- resolution of an ipfs hash can take a really long time and create a large http worker pool, this was adjusted slightly but can be improved.

- stronger authentication guarantees on the wallet signer, possibly by requirng the user sign data with a timestamp or reference

- barebones minimal client ui

## Installation

add to `config/dev.exs` or `config/config.exs`:

```
config :fnd,
  graphql_endpoint: "https://gateway.thegraph.com/api/",
  sub_graph: "33mhqfVG26N2V8pGNoEpnF5pSr2LbLg8VQRy7PL5EydY",
  key: <your api key>,
  client_api: Fnd.Graph.Client
```

then in `./assets`:

run `npm install react react-dom styled-components --save`

Finally, in the root to install dependencies:

- `mix deps.get`
- mix ecto.setup
Start Phoenix endpoint with mix phx.server or inside IEx with iex -S mix phx.server
