cask "agent-sushi" do
  version "0.1.9"
  sha256 "ef5dc2a1b8c2b3abc29bcfcbc840cdfbf283a4f1eb6cb162b2d3d23bfacf945c"

  url "https://github.com/kmatsushita1012/agent-sushi/releases/download/v#{version}/agent-sushi-#{version}.tar.gz"
  name "Agent Sushi"
  desc "Sushi-themed completion overlay for AI task notifications"
  homepage "https://github.com/kmatsushita1012/agent-sushi"

  app "AgentSushi.app"
  binary "agent-sushi"
end
