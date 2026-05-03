cask "agent-sushi" do
  version "0.1.7"
  sha256 "a1b3f0c138a96657c8d04d901537a1cb4f8b41e9ec267347d36c35475fc9210f"

  url "https://github.com/kmatsushita1012/agent-sushi/releases/download/v#{version}/agent-sushi-#{version}.tar.gz"
  name "Agent Sushi"
  desc "Sushi-themed completion overlay for AI task notifications"
  homepage "https://github.com/kmatsushita1012/agent-sushi"

  app "AgentSushi.app"
  binary "agent-sushi"
end
