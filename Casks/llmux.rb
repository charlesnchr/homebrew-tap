cask "llmux" do
  version "1.2.0"
  sha256 "7d12820493b05a718a81c5035b5a6ea97af38d885f94a60ad58f5c03cad05ce2"

  url "https://github.com/charlesnchr/llmux/releases/download/v#{version}/LLMux-#{version}-arm64-mac.zip"
  name "LLMux"
  desc "Universal LLM gateway — query ChatGPT, Claude, and Gemini simultaneously"
  homepage "https://github.com/charlesnchr/llmux"

  app "LLMux.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/LLMux.app"]
  end

  zap trash: [
    "~/Library/Application Support/LLMux",
    "~/Library/Preferences/com.charlesnchr.llmux.plist",
  ]
end
