cask "agent-sushi" do
  version "0.1.8"
  sha256 "6c88eea7490d510cee400f960c82143ddcd3c6ad6cacf735ee3d5fdbcb6a88f9"

  url "https://github.com/kmatsushita1012/agent-sushi/releases/download/v#{version}/agent-sushi-#{version}.tar.gz"
  name "Agent Sushi"
  desc "Sushi-themed completion overlay for AI task notifications"
  homepage "https://github.com/kmatsushita1012/agent-sushi"

  app "AgentSushi.app"
  binary "agent-sushi"
end
