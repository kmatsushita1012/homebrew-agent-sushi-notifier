cask "agent-sushi" do
  version "0.1.0"
  sha256 "REPLACE_WITH_SHA256"

  url "https://github.com/REPO_OWNER/agent-sushi/releases/download/v#{version}/agent-sushi-#{version}.tar.gz"
  name "Agent Sushi"
  desc "Sushi-themed completion overlay for AI task notifications"
  homepage "https://github.com/REPO_OWNER/agent-sushi"

  app "SushiArrived.app"
  binary "agent-sushi"
end
