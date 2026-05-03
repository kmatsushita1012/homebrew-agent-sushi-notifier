cask "agent-sushi" do
  version "0.1.8"
  sha256 "e849cc669e5eb660c51132ccf9631545a85349ce61fc23780a8555387f646f58"

  url "https://github.com/kmatsushita1012/agent-sushi/releases/download/v#{version}/agent-sushi-#{version}.tar.gz"
  name "Agent Sushi"
  desc "Sushi-themed completion overlay for AI task notifications"
  homepage "https://github.com/kmatsushita1012/agent-sushi"

  app "AgentSushi.app"
  binary "agent-sushi"
end
