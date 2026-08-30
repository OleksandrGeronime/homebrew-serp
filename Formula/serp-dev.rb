class SerpDev < Formula
  desc "SERP development files, code generator, and standalone AI runner"
  homepage "https://github.com/OleksandrGeronime/serp"
  version "0.10.2"
  license "Proprietary"

  on_macos do
    on_arm do
      url "https://github.com/OleksandrGeronime/serp/releases/download/v#{version}/serp-dev-#{version}-arm64_sequoia.tar.gz"
      sha256 "60d1aad352d64dfa4d6678f42e0c2f30b735699c81aa55545958897954d5996e"
    end
    on_intel do
      url "https://github.com/OleksandrGeronime/serp/releases/download/v#{version}/serp-dev-#{version}-x86_64_ventura.tar.gz"
      sha256 "FILL_X86_SERPDEV_SHA256"
    end
  end

  depends_on "OleksandrGeronime/serp/serp"

  def install
    # Namelinks for runtime libs (versioned files come from the `serp` dependency)
    lib.install Dir["lib/libserp_*.dylib"].reject { |f| f =~ /\.\d+\./ }
    # Full install for dev-only libs (runtime adapter + test engine)
    lib.install Dir["lib/libserp_runtime*.dylib"]
    lib.install Dir["lib/libserp_test_engine*.dylib"]

    # Public headers
    include.install "include/serp"

    # CMake package config
    (lib/"cmake").install "lib/cmake/Serp"

    # serpgen binary (nuitka standalone — needs its sibling .so files)
    (libexec/"serpgen").install Dir["libexec/serpgen/*"]
    bin.write_exec_script libexec/"serpgen/serpgen"

    # serpai standalone bundle is kept separate from serpgen's sibling libraries.
    (libexec/"serpai").install Dir["libexec/serpai/*"]
    bin.write_exec_script libexec/"serpai/serpai"
  end

  test do
    assert_predicate include/"serp/core/App.hpp", :exist?
    assert_predicate lib/"cmake/Serp/SerpConfig.cmake", :exist?
    system bin/"serpgen", "--version"
    system bin/"serpai", "--version"
  end
end
