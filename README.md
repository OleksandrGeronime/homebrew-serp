# SERP — Binary Distribution

SERP is a C++ distributed system generation platform: spec → IR → generated multiprocess system.

## Packages

| Package | Contents |
|---|---|
| `serp` | Runtime shared libraries (deploy your app) |
| `serp-dev` | Headers, CMake config, engineering libs, `serpgen` code generator |

---

## macOS

### One-liner (recommended)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/OleksandrGeronime/homebrew-serp/main/install.sh)"
```

Installs `serp-dev` (includes everything). Runtime-only:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/OleksandrGeronime/homebrew-serp/main/install.sh)" -- serp
```

### Manual (Homebrew)

```bash
brew tap OleksandrGeronime/serp
brew trust OleksandrGeronime/serp
brew install OleksandrGeronime/serp/serp-dev   # or: serp
```

### Verify

```bash
serpgen --version
```

### Update

```bash
brew update
brew upgrade OleksandrGeronime/serp/serp-dev
```

---

## Ubuntu / Debian

### Manual install

Download the latest `.deb` packages from the [Releases](https://github.com/OleksandrGeronime/homebrew-serp/releases/latest) page and install:

```bash
# Replace x.y.z with the version you want
VERSION=0.4.3

wget https://github.com/OleksandrGeronime/homebrew-serp/releases/download/v${VERSION}/serp_${VERSION}_amd64.deb
wget https://github.com/OleksandrGeronime/homebrew-serp/releases/download/v${VERSION}/serp-dev_${VERSION}_amd64.deb

sudo dpkg -i serp_${VERSION}_amd64.deb serp-dev_${VERSION}_amd64.deb
```

### Verify

```bash
serpgen --version
```

---

## CMake integration

After installing `serp-dev`:

```cmake
find_package(Serp REQUIRED)
target_link_libraries(your_target serp::serp_core serp::serp_logger)
```
