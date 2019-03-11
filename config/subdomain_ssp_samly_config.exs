use Mix.Config

config :samly, Samly.State,
  store: Samly.State.Session,
  opts: [key: "my_samly_state_session_key"]

config :samly, Samly.Provider,
  idp_id_from: :subdomain,
  service_providers: [
    %{
      id: "samly_sp",
      entity_id: "urn:samly.howto:samly_sp",
      certfile: "priv/cert/samly_sp.pem",
      keyfile: "priv/cert/samly_sp_key.pem",
      contact_name: "Samly SP Admin",
      contact_email: "samly-sp-admin@samly.howto",
      org_name: "Samly Howto SP",
      org_displayname: "Samly Howto SP Displayname",
      org_url: "https://samly.howto:4443"
    }
  ],
  identity_providers: [
    %{
      id: "idp2",
      sp_id: "samly_sp",
      base_url: "https://idp2.samly.howto:4443/sso",
      metadata_file: "idp2_metadata.xml",
      pre_session_create_pipeline: SamlyHowtoWeb.Plugs.SamlyPipeline,
      allow_idp_initiated_flow: true,
      use_redirect_for_req: false,
      sign_requests: true,
      sign_metadata: true,
      signed_assertion_in_resp: true,
      signed_envelopes_in_resp: true
    },
    %{
      id: "idp3",
      sp_id: "samly_sp",
      base_url: "https://idp3.samly.howto:4443/sso",
      metadata_file: "idp3_metadata.xml",
      pre_session_create_pipeline: SamlyHowtoWeb.Plugs.SamlyPipeline,
      use_redirect_for_req: false,
      sign_requests: true,
      sign_metadata: true,
      signed_assertion_in_resp: true,
      signed_envelopes_in_resp: true
    }
  ]
