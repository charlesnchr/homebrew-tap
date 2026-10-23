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
  url "https://github.com/charlesnchr/bento/releases/download/v0.1.0/Bento-0.1.0.zip", using: :nounzip
  version "0.1.0"
  sha256 "5b7823da9ee9e5ad3e4460146fad4ee7b1c60de2aa5c8c28fcd786b8acf9be7e"
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
      and grant Accessibility and Screen Recording when it asks. To find it in
      Spotlight or Raycast:
        mkdir -p ~/Applications && ln -sfn #{opt_prefix}/Bento.app ~/Applications/Bento.app
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
