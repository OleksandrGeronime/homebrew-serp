class SerpDev < Formula
  desc "SERP development files, code generator, and standalone AI runner"
  homepage "https://github.com/OleksandrGeronime/serp"
  version "0.12.5"
  license "Proprietary"

  on_macos do
    on_arm do
      url "https://github.com/OleksandrGeronime/serp/releases/download/v#{version}/serp-dev-#{version}-arm64_sequoia.tar.gz"
      sha256 "7ce6442c8aaab252784fc1ee61ac12ea25a315d3278dece4e55f38ca4bd1f2c4"
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
    (lib/"cmake").install "lib/cmake/SerpUi" if File.directory?("lib/cmake/SerpUi")

    # serp_ui source-only UI SDK: its own headers (share/serp/ui/include) plus
    # the common/, lvgl/, swiftui/ and compose/ source+CMake trees
    # that SerpUiConfig.cmake points generated consumers at. Installed as a
    # unit under share/serp/ui by serp_ui/CMakeLists.txt.
    if File.directory?("share/serp/ui")
      (share/"serp/ui").install Dir["share/serp/ui/*"]
    end

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
    # serp_ui source-only SDK: installed unconditionally regardless of
    # whether SERP itself was built with SERP_BUILD_UI_LVGL.
    assert_predicate lib/"cmake/SerpUi/SerpUiConfig.cmake", :exist?
    assert_predicate share/"serp/ui/lvgl/CMakeLists.txt", :exist?
    assert_predicate share/"serp/ui/lvgl/include/serp_ui/lvgl/ScreenHost.hpp", :exist?
    assert_predicate share/"serp/ui/swiftui/SerpHmiRuntime.swift", :exist?
    assert_predicate share/"serp/ui/swiftui/SerpHmiLayout.swift", :exist?
    assert_predicate share/"serp/ui/swiftui/SerpHmiScreenHost.swift", :exist?
    assert_predicate share/"serp/ui/compose/SerpHmiRuntime.kt", :exist?
    system bin/"serpgen", "--version"
    system bin/"serpai", "--version"
  end
end
