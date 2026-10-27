class Serp < Formula
  desc "SERP runtime libraries"
  homepage "https://github.com/OleksandrGeronime/serp"
  version "0.12.5"
  license "Proprietary"

  on_macos do
    on_arm do
      url "https://github.com/OleksandrGeronime/serp/releases/download/v#{version}/serp-#{version}-arm64_sequoia.tar.gz"
      sha256 "d61cceb82691dc5ebd0b1e3847d9a22a8c2c9906b1902b6facacba5c86495491"
    end
    on_intel do
      url "https://github.com/OleksandrGeronime/serp/releases/download/v#{version}/serp-#{version}-x86_64_sequoia.tar.gz"
      sha256 "d62f469864c14e6fa0253cb43f55910d3de94cb6086cf4f72707bd7d3ebe45ce"
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
