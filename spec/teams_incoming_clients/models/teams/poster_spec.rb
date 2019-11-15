RSpec.describe Teams::Poster do
  describe "#initialize" do
    # エラー検知のためブロック化している
    subject { -> { Teams::Poster.new(webhook_url) } }
    context "(webhook_urlがnilのとき)" do
      let(:webhook_url) { nil }
      it { is_expected.to raise_error(ArgumentError) }
    end

    context "(webhook_urlが空文字のとき)" do
      let(:webhook_url) { "" }
      it { is_expected.to raise_error(ArgumentError) }
    end

    context "(webhook_urlが空ではない文字列のとき)" do
      let(:webhook_url) { "https://example.com/webhook" }
      it { is_expected.not_to be_nil }
    end
  end

  describe "#post" do
    subject { client.post("test with #{Time.new}") }
    let(:client) { Teams::Poster.new(webhook_url) }
    context "(送信が成功するとき)" do
      # テスト用の正しいWEBHOOKを設定しておくこと
      let(:webhook_url) { ENV["TIWC_SPEC_WEBHOOK_URL"] }
      # 基本本当の通信がはいるので保留
      xit { is_expected.to eq true }
    end

    context "(送信が失敗するとき)" do
      # テスト用の正しいWEBHOOKを設定しておくこと
      let(:webhook_url) { "https://example.com/invalid/dummy/url" }
      it { is_expected.to eq false }
    end
  end
end
