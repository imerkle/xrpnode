defmodule XrpnodeWeb.RPCController do
      use XrpnodeWeb, :controller
      
      def account_info(conn, %{"node"=>node, "address" => address}) do
        body = Jason.encode!(%{
          method: "account_info",
          params: [
              %{
                  account: address,
                  strict: true,
                  ledger_index: "current",
                  queue: true
              }
          ]
        })
        json(conn, node_call(body, node))
      end
      
      
      def account_tx(conn, %{"node"=>node, "address" => address, "limit" => limit}) do
        body = Jason.encode!(%{
            method: "account_tx",
            params: [
                %{
                    account: address,
                    binary: false,
                    forward: false,
                    ledger_index_max: -1,
                    ledger_index_min: -1,
                    limit: limit
                }
            ]
        })
        json(conn, node_call(body, node))
      end

      def tx_submit(conn, %{"node"=>node, "tx_blob" => tx_blob}) do
        body = Jason.encode!(%{
              method: "submit",
              params: [
                  %{
                      tx_blob: tx_blob
                  }
              ]
          })
        json(conn, node_call(body, node))
      end

      def fee(conn, %{"node"=>node}) do
        body = Jason.encode!(%{
          method: "fee",
          params: [%{}]
        })
        json(conn, node_call(body, node))
      end

      def server_state(conn, %{"node"=>node}) do
        body = Jason.encode!(%{
          method: "server_state",
          params: [%{}]
        })
        json(conn, node_call(body, node))
      end

      def node_call(body, node) do
        header = [{"Accept", "application/json"},{"Content-Type", "application/json"}]
        response = HTTPotion.post get_node(node), [body: body, headers: header]
        Jason.decode!(response.body)
      end

      def get_node(node) do
        if node == "test" do
          "https://s.altnet.rippletest.net:51234"
        else
          "http://s1.ripple.com:51234"
        end
      end 
end