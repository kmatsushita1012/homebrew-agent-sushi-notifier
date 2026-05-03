cask "agent-sushi" do
  version "0.1.8"
  sha256 "815ae6a94c6f4a2f80733428d74eb3400759f04ae955545a0b47ed5c525cf62c"

  url "https://github.com/kmatsushita1012/agent-sushi/releases/download/v#{version}/agent-sushi-#{version}.tar.gz"
  name "Agent Sushi"
  desc "Sushi-themed completion overlay for AI task notifications"
  homepage "https://github.com/kmatsushita1012/agent-sushi"

  app "AgentSushi.app"
  binary "agent-sushi"
end
