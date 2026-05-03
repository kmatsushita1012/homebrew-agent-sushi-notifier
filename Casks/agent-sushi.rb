cask "agent-sushi" do
  version "0.1.8"
  sha256 "17f2ecb8cb55d5bc8292c5536a3cb8be62b22321b6d39327f910ddd72b550698"

  url "https://github.com/kmatsushita1012/homebrew-agent-sushi/releases/download/v#{version}/agent-sushi-#{version}.tar.gz"
  name "Agent Sushi"
  desc "Sushi-themed completion overlay for AI task notifications"
  homepage "https://github.com/kmatsushita1012/homebrew-agent-sushi"

  app "AgentSushi.app"
  binary "agent-sushi"
end
