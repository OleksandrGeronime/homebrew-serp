class Serp < Formula
  desc "SERP runtime libraries"
  homepage "https://github.com/OleksandrGeronime/serp"
  version "0.9.0"
  license "Proprietary"

  on_macos do
    on_arm do
      url "https://github.com/OleksandrGeronime/serp/releases/download/v#{version}/serp-#{version}-arm64_sequoia.tar.gz"
      sha256 "039dd78caf94b7b33854fb1b496e0209f93e267105c26fec4191faeef371c753"
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
