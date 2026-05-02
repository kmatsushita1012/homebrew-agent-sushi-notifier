cask "agent-sushi" do
  version "0.1.3"
  sha256 "123db51bf2d1249d967c08f0465f0d659844f452217f87e9832f6db8669ea98c"

  url "https://github.com/kmatsushita1012/homebrew-agent-sushi-notifier/releases/download/v#{version}/agent-sushi-#{version}.tar.gz"
  name "Agent Sushi"
  desc "Sushi-themed completion overlay for AI task notifications"
  homepage "https://github.com/kmatsushita1012/homebrew-agent-sushi-notifier"

  app "SushiArrived.app"
  binary "agent-sushi"
end
