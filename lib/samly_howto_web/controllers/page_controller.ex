defmodule SamlyHowtoWeb.PageController do
  use SamlyHowtoWeb, :controller

  def index(conn, _params) do
    assertion = Samly.get_active_assertion(conn)
    uid = Samly.get_attribute(assertion, "uid")
    {idp_id, attributes, computed} = if assertion do
      {assertion.idp_id, assertion.attributes, assertion.computed}
    else
      {nil, nil, nil}
    end

    target_url = "/?a=value1&b=value two" |> URI.encode_www_form()
    {metadata_uri, signin_uri, signout_uri} = get_samly_uris()
    render conn, "index.html", [
      idp_id: idp_id,
      uid: uid,
      attributes: attributes,
      computed: computed,
      target_url: target_url,
      metadata_uri: metadata_uri,
      signin_uri: signin_uri,
      signout_uri: signout_uri
    ]
  end

  defp get_samly_uris() do
    opts = Application.get_env(:samly, Samly.Provider, [])
    if opts[:idp_id_from] == :subdomain do
      {
        "/sso/sp/metadata",
        "/sso/auth/signin",
        "/sso/auth/signout"
      }
    else
      {
        "/sso/sp/metadata/idp1",
        "/sso/auth/signin/idp1",
        "/sso/auth/signout/idp1"
      }
    end
  end
end
