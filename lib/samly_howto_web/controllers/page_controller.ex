defmodule SamlyHowtoWeb.PageController do
  use SamlyHowtoWeb, :controller

  alias Samly.Assertion

  def index(conn, params) do
    assertion = Samly.get_active_assertion(conn)

    opts = Application.get_env(:samly, Samly.Provider, [])
    idp_in_uri_type = Keyword.get(opts, :idp_id_from, :path_segment)

    idp_id =
      case {idp_in_uri_type, get_assertion_idp_id(assertion)} do
        {_, idp_id} when idp_id != nil -> idp_id
        {:path_segment, _} -> Map.get(params, "idp", "idp1")
        _ -> nil
      end

    demo_target_qp = %{a: "value one", b: "value two"}

    demo_target_qp =
      case idp_in_uri_type do
        :path_segment -> Map.put(demo_target_qp, :idp_id, idp_id)
        :subdomain -> demo_target_qp
      end

    demo_target_uri = URI.to_string(%URI{path: "/", query: URI.encode_query(demo_target_qp)})

    IO.inspect(demo_target_uri, label: "target_url")

    signin_uri_with_target =
      URI.to_string(%URI{
        path: get_signin_uri(idp_id, idp_in_uri_type),
        query: URI.encode_query(%{target_url: demo_target_uri})
      })

    signout_uri_with_target =
      URI.to_string(%URI{
        path: get_signout_uri(idp_id, idp_in_uri_type),
        query: URI.encode_query(%{target_url: demo_target_uri})
      })

    assigns = %{
      idp_id: idp_id,
      uid: Samly.get_attribute(assertion, "uid"),
      attributes: get_assertion_attributes(assertion),
      computed: get_assertion_computed_attributes(assertion),
      metadata_uri: get_metadata_uri(idp_id, idp_in_uri_type),
      signin_uri: signin_uri_with_target,
      signout_uri: signout_uri_with_target
    }

    render(conn, "index.html", assigns)
  end

  defp get_assertion_idp_id(%Assertion{idp_id: idp_id}), do: idp_id
  defp get_assertion_idp_id(nil), do: nil

  defp get_assertion_attributes(%Assertion{attributes: attributes}), do: attributes
  defp get_assertion_attributes(nil), do: nil

  defp get_assertion_computed_attributes(%Assertion{computed: computed}), do: computed
  defp get_assertion_computed_attributes(nil), do: nil

  defp get_metadata_uri(_idp_id, :subdomain), do: "/sso/sp/metadata"
  defp get_metadata_uri(idp_id, :path_segment), do: "/sso/sp/metadata/#{idp_id}"

  defp get_signin_uri(_idp_id, :subdomain), do: "/sso/auth/signin"
  defp get_signin_uri(idp_id, :path_segment), do: "/sso/auth/signin/#{idp_id}"

  defp get_signout_uri(_idp_id, :subdomain), do: "/sso/auth/signout"
  defp get_signout_uri(idp_id, :path_segment), do: "/sso/auth/signout/#{idp_id}"
end
