Taiga contrib threefold auth
=========================
The Taiga plugin for threefold authentication (Ported from official Gitlab auth).

## Production env

Take the latest release of this repository, for instance:

```
export TAIGA_CONTRIB_THREEFOLD_AUTH_TAG=1.0.0
```

### Taiga Back

Load the python virtualenv from your Taiga back directory:

```bash
source .venv/bin/activate
```

And install the package `taiga-contrib-threefold-auth-official` with:

```bash
  (taiga-back) pip install "git+https://github.com/sameh-farouk/taiga-contrib-threefold-auth.git@${TAIGA_CONTRIB_THREEFOLD_AUTH_TAG}#egg=taiga-contrib-threefold-auth-official&subdirectory=back"
```

Modify your `settings/config.py` and include the line:

```python
  INSTALLED_APPS += ["taiga_contrib_threefold_auth"]

  THREEFOLD_API_APP_SECRET = "YOUR-THREEFOLD-APP-SECRET"  # required
  THREEFOLD_URL = "https://login.threefold.me"  # optional. can be used to override the default url
  THREEFOLD_OPENKYC_URL ="https://openkyc.live/verification/verify-sei"  # optional. can be used to override the default url
```

To get the THREEFOLD_API_APP_SECRET do:

```python
import nacl
import nacl.signing
sk = nacl.signing.SigningKey.generate()
sk_to_b64 = sk.encode(encoder=nacl.encoding.Base64Encoder).decode()  # this is the signing key. use it for THREEFOLD_API_APP_SECRET setting.

vk = sk.verify_key
pubkey = vk.to_curve25519_public_key().encode(encoder=nacl.encoding.Base64Encoder).decode()  # this is the app public key. you will need it for the front end `threeFoldAppPubKey` setting.
``` 
**Tip** the callback url in the Threefold configuration should be the same as the `{TAIGA_URL}/login` environment variable.


### Taiga Front

Download in your `dist/plugins/` directory of Taiga front the `taiga-contrib-threefold-auth` compiled code (you need subversion in your system):

```bash
  cd dist/
  mkdir -p plugins
  cd plugins
  svn export "https://github.com/sameh-farouk/taiga-contrib-threefold-auth.gi/tags/${TAIGA_CONTRIB_THREEFOLD_AUTH_TAG}/front/dist"  "threefold-auth"
```

Include in your `dist/conf.json` in the 'contribPlugins' list the value `"plugins/threefold-auth/threefold-auth.json"`:

```json
...
  "threeFoldAppPubKey": "YOUR-THREEFOLD-APP-PUBLIC-KEY",  // required 
  "threeFoldAppId": "YOUR-THREEFOLD-APP-ID",  // optional, use your hostname ex. circles.threefold.me 
  "threeFoldUrl": "https://login.threefold.me", // optional, can be used to override the default url
  "contribPlugins": [
    (...)
    "plugins/threefold-auth/threefold-auth.json"
  ]
...
```

## Dev env

This configuration should be used only if you're developing this library.

### Taiga Back

Clone the repo and

```bash
  cd taiga-contrib-threefold-auth/back
  workon taiga
  pip install -e .
```

Modify `taiga-back/settings/local.py` and include the line:

```python
  INSTALLED_APPS += ["taiga_contrib_threefold_auth"]

  THREEFOLD_API_APP_SECRET = "YOUR-THREEFOLD-APP-SECRET"  # required
  THREEFOLD_URL = "https://login.threefold.me"  # optional. can be used to override the default url
  THREEFOLD_OPENKYC_URL ="https://openkyc.live/verification/verify-sei"  # optional. can be used to override the default url
```

To get the THREEFOLD_API_APP_SECRET do:

```python
import nacl
import nacl.signing
sk = nacl.signing.SigningKey.generate()
sk_to_b64 = sk.encode(encoder=nacl.encoding.Base64Encoder).decode()  # this is the signing key. use it for THREEFOLD_API_APP_SECRET setting.

vk = sk.verify_key
pubkey = vk.to_curve25519_public_key().encode(encoder=nacl.encoding.Base64Encoder).decode()  # this is the app public key. you will need it for the front end `threeFoldAppPubKey` setting.

``` 

### Taiga Front

After clone the repo link `dist` in `taiga-front` plugins directory:

```bash
  cd taiga-front/dist
  mkdir -p plugins
  cd plugins
  ln -s ../../../taiga-contrib-threefold-auth/front/dist threefold-auth
```

Include in your `dist/conf.json` in the 'contribPlugins' list the value `"plugins/threefold-auth/threefold-auth.json"`:

```json
...
  "threeFoldAppPubKey": "YOUR-THREEFOLD-APP-PUBLIC-KEY",  // required 
  "threeFoldAppId": "YOUR-THREEFOLD-APP-ID",  // optional, use your hostname ex. circles.threefold.me 
  "threeFoldUrl": "https://login.threefold.me", // optional, can be used to override the default url
  "contribPlugins": [
    (...)
    "plugins/threefold-auth/threefold-auth.json"
  ]
...
```

In the plugin source dir `taiga-contrib-threefold-auth/front` run

```bash
npm install
```
and use:

- `gulp` to regenerate the source and watch for changes.
- `gulp build` to only regenerate the source.

## Running tests

not yet

## disable the normal login and registeration:
If you like to keep only Threefold login and registration and disable the default login and the public registration, include in your `dist/conf.json` these values

```json
  "defaultLoginEnabled": false,
  "publicRegisterEnabled": false,
```

## Taiga Documentation

Currently, we have authored three main documentation hubs:

- **[API](https://docs.taiga.io/api.html)**: Our API documentation and reference for developing from Taiga API.
- **[Documentation](https://docs.taiga.io/)**: If you need to install Taiga on your own server, this is the place to find some guides.
- **[Taiga Resources](https://resources.taiga.io)**: This page is intended to be the support reference page for the users.

## Taiga Bug reports

If you **find a bug** in Taiga you can always report it:

- in [Taiga issues](https://tree.taiga.io/project/taiga/issues). **This is the preferred way**
- in [Github issues](https://github.com/kaleidos-ventures/taiga-contrib-threefold-auth/issues)
- send us a mail to support@taiga.io if is a bug related to [tree.taiga.io](https://tree.taiga.io)
- send us a mail to security@taiga.io if is a **security bug**

One of our fellow Taiga developers will search, find and hunt it as soon as possible.

Please, before reporting a bug, write down how can we reproduce it, your operating system, your browser and version, and if it's possible, a screenshot. Sometimes it takes less time to fix a bug if the developer knows how to find it.

## Taiga Community

If you **need help to setup Taiga**, want to **talk about some cool enhancemnt** or you have **some questions**, please write us to our [mailing list](https://groups.google.com/d/forum/taigaio).

If you want to be up to date about announcements of releases, important changes and so on, you can subscribe to our newsletter (you will find it by scrolling down at [https://taiga.io](https://www.taiga.io/)) and follow [@taigaio](https://twitter.com/taigaio) on Twitter.

## Contribute to Taiga

There are many different ways to contribute to Taiga's platform, from patches, to documentation and UI enhancements, just find the one that best fits with your skills. Check out our detailed [contribution guide](https://resources.taiga.io/extend/how-can-i-contribute/)
