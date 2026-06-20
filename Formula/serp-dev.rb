class SerpDev < Formula
  desc "SERP development files and code generator"
  homepage "https://github.com/OleksandrGeronime/serp"
  version "0.4.0"
  license "Proprietary"

  on_macos do
    on_arm do
      url "https://github.com/OleksandrGeronime/homebrew-serp/releases/download/v#{version}/serp-dev-#{version}-arm64_sequoia.tar.gz"
      sha256 "b2fefbfcf5d72b97be045d2a23acacc0a76315cf759ae5cd3902aa2f57cdae18"
    end
    on_intel do
      url "https://github.com/OleksandrGeronime/homebrew-serp/releases/download/v#{version}/serp-dev-#{version}-x86_64_sequoia.tar.gz"
      sha256 "FILL_IN_BY_CI"
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
    libexec.install "libexec/core"
    bin.write_exec_script libexec/"core/serpgen"
  end

  test do
    assert_predicate include/"serp/core/App.hpp", :exist?
    assert_predicate lib/"cmake/Serp/SerpConfig.cmake", :exist?
    system bin/"serpgen", "--version"
  end
end
