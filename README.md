# SamlyHowto

A Phoenix application that demonstrates how it is turned into a
SAML Service Provider using [`Samly`](https://github.com/handnot2/samly)
Elixir library.

```sh
# add the following to your /etc/hosts file:
# 127.0.0.1 samly.howto

git clone https://github.com/handnot2/samly_howto
cd samly_howto
./gencert.sh
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
URL: `http://samly.howto:4003`
