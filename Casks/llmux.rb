cask "llmux" do
  version "1.1.0"
  sha256 "dafcb7899533d5dd9c2934098953e1f6008a1df8d033fafbf131c91ea9af73d5"

  url "https://github.com/charlesnchr/llmux/releases/download/v#{version}/LLMux-#{version}-arm64-mac.zip"
  name "LLMux"
  desc "Universal LLM gateway — query ChatGPT, Claude, and Gemini simultaneously"
  homepage "https://github.com/charlesnchr/llmux"

  app "LLMux.app"

  zap trash: [
    "~/Library/Application Support/LLMux",
    "~/Library/Preferences/com.charlesnchr.llmux.plist",
  ]
end
