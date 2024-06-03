![ApparenceKit flutter starter kit header](/docs/img/header.png)

<br/>

![Apparence clients](/docs/img/trust.png)

<br/>

[![style: lint](https://img.shields.io/badge/style-lint-4BC0F5.svg)](https://pub.dev/packages/lint)
[![Http client boilerplate build status](https://github.com/Apparence-io/ApparenceKit-pro/actions/workflows/http_client.yml/badge.svg)](https://github.com/Apparence-io/ApparenceKit-pro/actions/workflows/http_client.yml)
[![supabase](https://github.com/Apparence-io/ApparenceKit-pro/actions/workflows/supabase.yml/badge.svg)](https://github.com/Apparence-io/ApparenceKit-pro/actions/workflows/supabase.yml)
[![Firebase boilerplate build status](https://github.com/Apparence-io/ApparenceKit-pro/actions/workflows/firebase.yml/badge.svg)](https://github.com/Apparence-io/ApparenceKit-pro/actions/workflows/firebase.yml)

# Apparence.io Flutter starter kit (Pro version)

## Getting Started

This project is a starter kit for Flutter apps by Apparence.io. <br/>

## Install the CLI

For this we will use the dart pub command

```bash
dart pub global activate --source git https://github.com/Apparence-io/ApparenceKit-pro --git-path cli
```

Check the complete documentation here

[![ApparenceKit flutter starter kit doc](/docs/img/doc-link.png)](https://apparencekit.dev/docs/start/overview)

## Features

| Features                                       | Included |
| :--------------------------------------------- | :------: |
| 🧪 Multiple environments (dev,staging,prod...) |    ✅    |
| 📦 Modular architecture example                |    ✅    |
| 📲 Repository pattern example                  |    ✅    |
| ⏳ App initializer                             |    ✅    |
| 👨‍💻 Authentication state + token storage      |    ✅    |
| 🔓 Guards example                              |    ✅    |
| 📭 Email signup page                           |    ✅    |
| 🚪 Email signin page                           |    ✅    |
| 🔐 Password recovery page                      |    ✅    |
| 📱 Easy bottom bar setup (+ adaptive with OS)  |    ✅    |
| 👍 Onboarding intro screens                    |    ✅    |
| 🚩 Advanced Unit tests examples                |    ✅    |
| 🖥️ CI setup                                     |    ✅    |
| 🎨 Enhanced theme manager                      |    ✅    |
| 💼 Regular dependencies versions check         |    ✅    |
| 🔔 Handle notifications                        |    ✅    |
| 💰 In app subscription (optionnal)             |    ✅    |
| 🤩 Google Ad mobs ready (optionnal)            |    ✅    |
| 😎 Social authentications (CLI command)        |    ✅    |
| 🏳️ Internationalization (optionnal)             |    ✅    |
| 📊 Analytics setup                             |    ✅    |
| 🚨 Error reporting using sentry (optionnal)    |    ✅    |

... and many more

**Need more features?**<br/> Request a feature by creating an issue with the
label 'feature request'.

## 📘 Guides

All documentations and guides are now on
[apparencekit.dev doc page.](https://apparencekit.dev/docs/start/overview) <br/>

**Development guides**

- [App architecture](./docs/architecture.md)
- [Writing a module](./docs/create_module.md)
- [Setup notifications](./docs/notifications.md)
- [Testing: how to write effective tests](./docs/tests.md)

## 👉 Code generation

As we use code generation in the whole project. You must run this command to
regenerate all the generated code from @freezed or other like json. For more
info refer to the freezed package
[documentation](https://pub.dev/packages/freezed).

```bash
dart pub run build_runner build --delete-conflicting-outputs
```

---

## Disclaimer

_You are free to use and change this code. But not to resell or diffuse publicly
this repository._

<br>
<br>

<a href="https://apparence.io">
  <img
    src="https://raw.githubusercontent.com/Apparence-io/camera_awesome/master/docs/img/apparence.png"
    width="100%"
  />
</a>
