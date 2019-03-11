defmodule SamlyHowtoWeb.Plugs.SamlyPipeline do
  use Plug.Builder
  alias Samly.{Assertion}

  plug :compute_attributes
  plug :jit_provision_user

  def compute_attributes(conn, _opts) do
    assertion = conn.private[:samly_assertion]

    first_name = Map.get(assertion.attributes, "first_name")
    last_name = Map.get(assertion.attributes, "last_name")

    computed = %{
      "full_name" => "#{first_name} #{last_name}",
      "name" => "#{assertion.subject.name}",
      "name_qualifier" => "#{assertion.subject.name_qualifier}",
      "sp_name_qualifier" => "#{assertion.subject.sp_name_qualifier}",
      "name_format" => "#{assertion.subject.name_format}",
      "notonorafter" => "#{assertion.subject.notonorafter}",
      "in_response_to" => "#{assertion.subject.in_response_to}"
    }

    assertion = %Assertion{assertion | computed: computed}

    conn
    |> put_private(:samly_assertion, assertion)

    # |>  send_resp(404, "attribute mapping failed")
    # |>  halt()
  end

  def jit_provision_user(conn, _opts) do
    conn
  end
end
