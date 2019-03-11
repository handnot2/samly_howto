use Mix.Config

config :samly, Samly.State,
  store: Samly.State.Session,
  opts: [key: "my_samly_state_session_key"]

config :samly, Samly.Provider,
  idp_id_from: :path_segment,
  service_providers: [
    %{
      id: "sp1",
      entity_id: "urn:samly.howto:samly_sp",
      certfile: "priv/cert/samly_sp.pem",
      keyfile: "priv/cert/samly_sp_key.pem",
      contact_name: "Samly Howto SP1 Admin",
      contact_email: "sp1-admin@samly.howto",
      org_name: "Samly Howto SP1",
      org_displayname: "Samly Howto SP1 Displayname",
      org_url: "https://samly.howto:4443"
    }
  ],
  identity_providers: [
    %{
      id: "idp1",
      sp_id: "sp1",
      base_url: "https://samly.howto:4443/sso",
      metadata_file: "idp1_metadata.xml",
      pre_session_create_pipeline: SamlyHowtoWeb.Plugs.SamlyPipeline,
      allow_idp_initiated_flow: true,
      use_redirect_for_req: false,
      sign_requests: true,
      sign_metadata: true,
      signed_assertion_in_resp: true,
      signed_envelopes_in_resp: true,
      nameid_format: :transient
    }
  ]
