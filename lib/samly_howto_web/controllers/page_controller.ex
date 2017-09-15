defmodule SamlyHowtoWeb.PageController do
  use SamlyHowtoWeb, :controller

  def index(conn, _params) do
    assertion = Samly.get_active_assertion(conn)
    uid = Samly.get_attribute(assertion, :uid)
    {attributes, computed} = if assertion do
      {assertion.attributes, assertion.computed}
    else
      {nil, nil}
    end

    target_url = "/?a=value1&b=value two" |> URI.encode_www_form()
    render conn, "index.html",
      uid: uid, attributes: attributes, computed: computed, target_url: target_url
  end
end
