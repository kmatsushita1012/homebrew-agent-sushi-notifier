cask "agent-sushi" do
  version "0.1.8"
  sha256 "0677b1563d25fe193758d915bd7a4e931498145f724e82e14f715e0c9d90634e"

  url "https://github.com/kmatsushita1012/agent-sushi/releases/download/v#{version}/agent-sushi-#{version}.tar.gz"
  name "Agent Sushi"
  desc "Sushi-themed completion overlay for AI task notifications"
  homepage "https://github.com/kmatsushita1012/agent-sushi"

  app "AgentSushi.app"
  binary "agent-sushi"
end
