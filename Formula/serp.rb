class Serp < Formula
  desc "SERP runtime libraries"
  homepage "https://github.com/OleksandrGeronime/serp"
  version "0.10.2"
  license "Proprietary"

  on_macos do
    on_arm do
      url "https://github.com/OleksandrGeronime/serp/releases/download/v#{version}/serp-#{version}-arm64_sequoia.tar.gz"
      sha256 "9866fde8a306aeb1f33847e3efb50faf224ab48af7b0e32178ebbc3b9653fb54"
    end
    on_intel do
      url "https://github.com/OleksandrGeronime/serp/releases/download/v#{version}/serp-#{version}-x86_64_ventura.tar.gz"
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
