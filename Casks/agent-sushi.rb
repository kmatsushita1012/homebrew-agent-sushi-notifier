cask "agent-sushi" do
  version "0.1.1"
  sha256 "f68ba043c9fa0b4124ba474c0c2f0a9456a8f3c93f1d900ce5b15e3fbbb79b74"

  url "https://github.com/kmatsushita1012/homebrew-agent-sushi-notifier/releases/download/v#{version}/agent-sushi-#{version}.tar.gz"
  name "Agent Sushi"
  desc "Sushi-themed completion overlay for AI task notifications"
  homepage "https://github.com/kmatsushita1012/homebrew-agent-sushi-notifier"

  app "SushiArrived.app"
  binary "agent-sushi"
end
