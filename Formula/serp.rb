class Serp < Formula
  desc "SERP runtime libraries"
  homepage "https://github.com/OleksandrGeronime/serp"
  version "0.4.0"
  license "Proprietary"

  on_macos do
    on_arm do
      url "https://github.com/OleksandrGeronime/homebrew-serp/releases/download/v#{version}/serp-#{version}-arm64_sequoia.tar.gz"
      sha256 "f9b94e2ee67ac70a325ae5a422372724d5c4b24076124271eacc272264fa3d12"
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
