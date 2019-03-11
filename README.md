# SamlyHowto

`SamlyHowto` is a Phoenix application that shows how to use the
[`Samly`](https://hex.pm/packages/samly) Elixir Plug library for
SAML 2.0 authentication. Once integrated, your Phoenix application
becomes a SAML Service Provider.

This Web application shows the attributes in the SAML Assertion
returned by the Identity Provider (IdP) upon successful user
authentication.

It is fairly easy to enable SAML 2.0 authentication using the
`samly` library. Often times, the initial hickups are related to
configuring your application with proper Identity Provider settings.

Use this project as a test application to make sure that you are
able to successfully authenticate with your IdP. Once confirmed,
you can use those configuration settings with your own application.
This help you in isolating and correcting any configuration issues.
The changes required are confined to the config settings.

### Local Setup

```sh
# add the following to your /etc/hosts file:
# 127.0.0.1 samly.howto idp2.samly.howto idp3.samly.howto
# 127.0.0.1 idp1.samly idp2.samly idp3.samly

git clone https://github.com/handnot2/samly_howto
cd samly_howto
mix deps.get
mix compile
cd assets && npm install && cd ..
```

### Generate Keys and Self-signed Certificates

```
mix phx.gen.cert --output priv/cert/samly_howto samly.howto idp2.samly.howto idp3.samly.howto
mix phx.gen.cert --output priv/cert/samly_sp sp.samly
```

The first command generates a certificate used for browser based HTTPS access to this
Phoenix application. The second command is used to generate the key and certificate
used for SAML communication with the IdP. The `priv/cert/samly_sp.pem` certificate
should be made available to your IdP so that the signed SAML requests from application are
handled properly by the IdP.

### Local Identity Provider (IdP) Setup

Follow the instructions in the `samly_simplesaml` Github repo to setup your own
SAML Identity Provider for development purposes.

> [samly_simplesaml](https://github.com/handnot2/samly_simplesaml)

If you prefer `Shibboleth` as your IdP, follow along the instructions in the blog post:

> [SAML Authentication for Phoenix](https://handnot2.github.io/blog/auth/saml-auth-for-phoenix) (based on Shibboleth 3.x)

### Cloud based Identity Providers

You can also work with very many cloud based SAML 2.0 Identity Providers. The instructions are specific
to the IdP vendors. Checkout the `Samly` documentation for any Service Provider information you need
as part of setting up your IdP to work with your `Samly` enabled application.

> [Samly Documentation](https://hexdocs.pm/samly)

### Identity Provider Metadata

Make your Identity Provider's Metadata available to your Phoenix SAML
Service Provider application in XML form. How you get this metadata
XML is specific to your IdP.

### Configure Samly

Checkout instructions in the [Samly Documentation](https://hexdocs.pm/samly)
on how to configure `samly`.

### Start Application

Start this application by running

```sh
./runit.sh
```

This application can now be accessed from the browser by visiting the
URL: `https://samly.howto:4443`. If you are using a subdomain model the URL
would be something like: `https://idp2.samly.howto:4443`.

