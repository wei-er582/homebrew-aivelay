class AivelayCode < Formula
  desc "Aivelay Claude Code shell using Anthropic's official runtime delivery"
  homepage "https://code.aivelay.com"
  version "1.0.0"
  url "https://code.aivelay.com/downloads/assets/claude-code-macos-arm64-v1.0.0.tar.gz"
  sha256 "a8508aad2fdcae5fee70332bcd99aa8125b150b0b57b5585acf5ec0343ce4b7c"
  depends_on arch: :arm64
  depends_on macos: :big_sur

  def install
    libexec.install Dir["*"]
    %w[aivelay-code claude-code-weilai].each do |command|
      (bin/command).write <<~SH
        #!/bin/sh
        exec "#{libexec}/#{command}" "$@"
      SH
    end
  end

  test do
    refute_predicate libexec/"runtime/claude-code", :exist?
    assert_match "official-download", (libexec/"runtime-delivery.json").read
    assert_predicate libexec/"legal/legal-layout.json", :exist?
    system bin/"aivelay-code", "help"
  end
end
