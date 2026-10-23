# Homebrew formula for Bento. scripts/release.sh fills in the version and
# checksum and publishes it as Formula/bento.rb in charlesnchr/homebrew-tap.
#
# A formula rather than a cask so the app lives in the Homebrew prefix
# (/opt/homebrew/opt/bento/Bento.app) and installs without admin rights or a
# quarantine flag. The archive is the release build, signed with the same
# certificate every time, so updates keep the Accessibility and Screen
# Recording grants.
class Bento < Formula
  desc "Menu-bar app for screenshots, window management, clipboard, notes and todos"
  homepage "https://github.com/charlesnchr/bento"
  url "https://github.com/charlesnchr/bento/releases/download/v0.1.2/Bento-0.1.2.zip", using: :nounzip
  version "0.1.2"
  sha256 "4d99b8bc4fab2492dd1d8c0db32b18a4f8a174ac69d894ececa7dd81ffbaeb6e"
  license "MIT"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  def install
    # ditto unpacks the bundle exactly as it was signed.
    system "/usr/bin/ditto", "-x", "-k", "Bento-#{version}.zip", prefix
  end

  def caveats
    <<~EOS
      Start Bento with:
        open #{opt_prefix}/Bento.app
      and grant Accessibility and Screen Recording when it asks. It adds an
      alias to itself in ~/Applications, so Spotlight and Raycast find it.
      Updates: Bento checks daily and installs them from its menu bar menu.
      After a brew upgrade in a terminal, restart Bento from that menu.
      Permission grants carry over.
    EOS
  end

  test do
    system "/usr/bin/codesign", "--verify", "--strict", prefix/"Bento.app"
    assert_equal version.to_s,
      shell_output("/usr/bin/defaults read #{prefix}/Bento.app/Contents/Info CFBundleShortVersionString").strip
  end
end
