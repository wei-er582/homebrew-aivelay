class AivelayCodex < Formula
  desc "Aivelay Codex CLI using the locked official runtime"
  homepage "https://code.aivelay.com"
  version "1.0.0"
  url "https://code.aivelay.com/downloads/assets/codex-macos-arm64-v1.0.0.tar.gz"
  sha256 "cfcb46ee71d2ba7f499ae4cb6dc3a54769aae98d6123421b7af778ec6f3f60c8"
  depends_on arch: :arm64
  depends_on macos: :big_sur

  def install
    libexec.install Dir["*"]
    %w[aivelay-codex codex-weilai].each do |command|
      (bin/command).write <<~SH
        #!/bin/sh
        exec "#{libexec}/#{command}" "$@"
      SH
    end
  end

  test do
    assert_match "bundled-redistributable", (libexec/"runtime-delivery.json").read
    assert_predicate libexec/"runtime/codex/runtime-layout.json", :exist?
    assert_predicate libexec/"runtime/codex/bin/codex", :executable?
    assert_predicate libexec/"legal/legal-layout.json", :exist?
    system bin/"aivelay-codex", "help"
  end
end
