class Serp < Formula
  desc "SERP runtime libraries"
  homepage "https://github.com/OleksandrGeronime/serp"
  version "0.4.5"
  license "Proprietary"

  on_macos do
    on_arm do
      url "https://github.com/OleksandrGeronime/homebrew-serp/releases/download/v#{version}/serp-#{version}-arm64_sequoia.tar.gz"
      sha256 "52e79ff12f0f38612317c1bc100a862ec3eb67950d93b1e8709c5641cdb048b2"
    end
    on_intel do
      url "https://github.com/OleksandrGeronime/homebrew-serp/releases/download/v#{version}/serp-#{version}-x86_64_ventura.tar.gz"
      sha256 "FILL_X86_SERP_SHA256"
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
