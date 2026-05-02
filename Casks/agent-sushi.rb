cask "agent-sushi" do
  version "0.1.5"
  sha256 "e0dd58344bfee7409a2a55e4229f54f53442c67f9cdbda128e0ff61539587cdf"

  url "https://github.com/kmatsushita1012/homebrew-agent-sushi-notifier/releases/download/v#{version}/agent-sushi-#{version}.tar.gz"
  name "Agent Sushi"
  desc "Sushi-themed completion overlay for AI task notifications"
  homepage "https://github.com/kmatsushita1012/homebrew-agent-sushi-notifier"

  app "SushiArrived.app"
  binary "agent-sushi"
end
