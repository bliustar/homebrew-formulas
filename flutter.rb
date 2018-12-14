class Flutter < Formula
  desc "Build beautiful native apps in record time"
  homepage "https://flutter.io/"
  version "1.1.1"
  url "https://github.com/flutter/flutter.git"
  sha256 "6e3ba2da94fb150d2cb8e0596eeb92c86e5e437e91a5f39f211bd4b21d0b24f8"

  bottle :unneeded

  def install
    system "git", "fetch", "--tags"

    # checkout latest tag
    latest_tag = `git tag | tail -1`
    puts latest_tag
    system "git checkout tags/#{latest_tag}"

    system "./bin/flutter"

    allfiles = File.join(buildpath, "**", "{*,.*}")
    mv Dir.glob(allfiles), Dir.glob(prefix), :force => true

    # bin.install File.join(prefix, "bin/cache/dart-sdk/bin/dart")
    # bin.install File.join(prefix, "bin/cache/dart-sdk/bin/pub")
  end

  def post_install
    rm File.join(HOMEBREW_PREFIX, "bin", "flutter.bat")
    chmod_R "+rwx", File.join(prefix, "bin"), :verbose => true
  end

  test do
    system "false"
  end
end
