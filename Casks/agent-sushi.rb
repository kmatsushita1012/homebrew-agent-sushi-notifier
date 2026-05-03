cask "agent-sushi" do
  version "0.1.8"
  sha256 "c793cbe51cf1d9161ca5a973f87c44159fadca2b0b43502de8d2292ce066ba64"

  url "https://github.com/kmatsushita1012/agent-sushi/releases/download/v#{version}/agent-sushi-#{version}.tar.gz"
  name "Agent Sushi"
  desc "Sushi-themed completion overlay for AI task notifications"
  homepage "https://github.com/kmatsushita1012/agent-sushi"

  app "AgentSushi.app"
  binary "agent-sushi"
end
