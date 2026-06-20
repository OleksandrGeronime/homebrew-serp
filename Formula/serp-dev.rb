class SerpDev < Formula
  desc "SERP development files and code generator"
  homepage "https://github.com/OleksandrGeronime/serp"
  version "0.4.0"
  license "Proprietary"

  on_macos do
    on_arm do
      url "https://github.com/OleksandrGeronime/homebrew-serp/releases/download/v#{version}/serp-dev-#{version}-arm64_sequoia.tar.gz"
      sha256 "fe7f3a389717d119ce9f8f8ba0a2ddeae38b05ba0f703cae1960f2855b5637d3"
    end
    on_intel do
      url "https://github.com/OleksandrGeronime/homebrew-serp/releases/download/v#{version}/serp-dev-#{version}-x86_64_sequoia.tar.gz"
      sha256 "FILL_IN_BY_CI"
    end
  end

  depends_on "OleksandrGeronime/serp/serp"

  def install
    # Engineering/debug libraries
    lib.install Dir["lib/libserp_*.dylib"]

    # Public headers
    include.install "include/serp"

    # CMake package config
    (lib/"cmake").install "lib/cmake/Serp"

    # serpgen binary (nuitka standalone — needs its sibling .so files)
    (libexec/"core").install Dir["libexec/core/*"]
    (bin/"serpgen").write_exec_script(libexec/"core/serpgen")
  end

  test do
    assert_predicate include/"serp/core/App.hpp", :exist?
    assert_predicate lib/"cmake/Serp/SerpConfig.cmake", :exist?
    system bin/"serpgen", "--version"
  end
end
