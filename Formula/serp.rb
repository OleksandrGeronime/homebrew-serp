class Serp < Formula
  desc "SERP runtime libraries"
  homepage "https://github.com/OleksandrGeronime/serp"
  version "0.4.0"
  license "Proprietary"

  on_macos do
    on_arm do
      url "https://github.com/OleksandrGeronime/homebrew-serp/releases/download/v#{version}/serp-#{version}-arm64_sequoia.tar.gz"
      sha256 "117708b4fb87e547500ad35340217c3eaa0ddac8c02a33fc2e621b99b70c95b8"
    end
    on_intel do
      url "https://github.com/OleksandrGeronime/homebrew-serp/releases/download/v#{version}/serp-#{version}-x86_64_sequoia.tar.gz"
      sha256 "FILL_IN_BY_CI"
    end
  end

  def install
    lib.install Dir["lib/libserp_*.dylib"]
  end

  test do
    assert_predicate lib/"libserp_core.0.dylib", :symlink?
    assert_predicate lib/"libserp_core.#{version}.dylib", :exist?
  end
end
