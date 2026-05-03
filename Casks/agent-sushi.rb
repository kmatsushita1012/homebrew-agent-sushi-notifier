cask "agent-sushi" do
  version "0.1.8"
  sha256 "05bb27bd2d8cf3278fd2ec2a39e5d0330e3e78a5c6d82c1e1d92d57b2f3b5ee2"

  url "https://github.com/kmatsushita1012/agent-sushi/releases/download/v#{version}/agent-sushi-#{version}.tar.gz"
  name "Agent Sushi"
  desc "Sushi-themed completion overlay for AI task notifications"
  homepage "https://github.com/kmatsushita1012/agent-sushi"

  app "AgentSushi.app"
  binary "agent-sushi"
end
