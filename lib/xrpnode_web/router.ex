defmodule XrpnodeWeb.Router do
  use XrpnodeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", XrpnodeWeb do
    pipe_through :api

    #post "/rpc", RPCController, :rpc
    get "/server_state", RPCController, :server_state
    get "/fee", RPCController, :fee
    get "/account_info", RPCController, :account_info
    get "/account_tx", RPCController, :account_tx
    post "/tx_submit", RPCController, :tx_submit
  end
end
