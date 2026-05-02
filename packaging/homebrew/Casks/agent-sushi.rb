cask "agent-sushi" do
  version "0.1.0"
  sha256 "ae0a468ff97aa2f8dae5352fed72d3d24f6dac1477bf3df0c8896b54fbe0eac7"

  url "https://github.com/kmatsushita1012/agent-sushi/releases/download/v#{version}/agent-sushi-#{version}.tar.gz"
  name "Agent Sushi"
  desc "Sushi-themed completion overlay for AI task notifications"
  homepage "https://github.com/kmatsushita1012/agent-sushi"

  app "SushiArrived.app"
  binary "agent-sushi"
end
