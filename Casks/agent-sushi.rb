cask "agent-sushi" do
  version "0.2.0"
  sha256 "e2f499e33cee281fc8e57cccf77ee94ad0c2d60de01bf2d97eb419495cb2cb58"

  url "https://github.com/kmatsushita1012/agent-sushi/releases/download/v#{version}/agent-sushi-#{version}.tar.gz"
  name "Agent Sushi"
  desc "Sushi-themed completion overlay for AI task notifications"
  homepage "https://github.com/kmatsushita1012/agent-sushi"

  app "AgentSushi.app"
  binary "agent-sushi"
end
