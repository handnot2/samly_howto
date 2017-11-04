# SamlyHowto

`SamlyHowto` is a Phoenix application that shows how to use the
[`Samly`](https://hex.pm/packages/samly) Elixir Plug library for
SAML 2.0 authentication. The Phoenix application becomes a
SAML Service Provider.

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
The changes required are confined to the `config/dev.exs` file.

```sh
# add the following to your /etc/hosts file:
# 127.0.0.1 samly.howto
# 127.0.0.1 idp2.samly.howto
# 127.0.0.1 idp3.samly.howto

git clone https://github.com/handnot2/samly_howto
cd samly_howto
./gencert.sh
cd assets && npm install && cd ..
mix deps.get
mix compile
```

> Before you can run this application, you need to setup an IdP. Checkout the
> instructions in the [Samly Documentation](https://hexdocs.pm/samly)

Make sure that the Docker compose based SimpleSAMLphp IdP is setup. Follow
the instructions there to establish mutual trust between the SimpleSAMLphp
IdP and this application.

Start this application by running

```sh
./runit.sh
```

This application can now be accessed from the browser by visiting the
URL: `http://samly.howto:4003`.
