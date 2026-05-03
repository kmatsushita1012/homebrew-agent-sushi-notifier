cask "agent-sushi" do
  version "0.1.8"
  sha256 "0c39d385d8f2225c24801fddca4fa739220dee88e8a3b642a9e0b4e89a2bb578"

  url "https://github.com/kmatsushita1012/agent-sushi/releases/download/v#{version}/agent-sushi-#{version}.tar.gz"
  name "Agent Sushi"
  desc "Sushi-themed completion overlay for AI task notifications"
  homepage "https://github.com/kmatsushita1012/agent-sushi"

  app "AgentSushi.app"
  binary "agent-sushi"
end
