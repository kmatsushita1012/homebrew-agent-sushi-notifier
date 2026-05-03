cask "agent-sushi" do
  version "0.1.6"
  sha256 "391784781927eda5dda55fd6aa20c9c0e31309ace89e8e2dfdfd3b27cb645573"

  url "https://github.com/kmatsushita1012/agent-sushi/releases/download/v#{version}/agent-sushi-#{version}.tar.gz"
  name "Agent Sushi"
  desc "Sushi-themed completion overlay for AI task notifications"
  homepage "https://github.com/kmatsushita1012/agent-sushi"

  app "SushiArrived.app"
  binary "agent-sushi"
end
