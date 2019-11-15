RSpec.describe Client do
  let(:client) { Client.new("https://example.com/webhook/url/xxxxx/xxxxx") }
  describe ".configure" do
    describe ".today_date" do
      after do
        Client.configure do |config|
          config.today_date = nil
        end
      end

      subject { Client.today_date }
      context "(何も設定していないとき)" do
        it { is_expected.to be_nil }
      end

      context "(日付設定するとき)" do
        let(:setting_date) { Date.parse("2019/01/01") }
        before do
          Client.configure do |config|
            config.today_date = setting_date
          end
        end
        it { is_expected.to eq setting_date }
      end
    end
  end

  describe "#post" do
    subject(:result) { client.post("message") }
    context "(送信に成功するとき)" do
      before do
        allow_any_instance_of(Teams::Poster).to receive(:post).and_return(true)
      end

      it "送信成功の結果が返ること" do
        expect(result).to be_ok
        expect(result.reason).to eq :success
        expect(result.message).to eq "status code 200"
      end
    end

    context "(送信に失敗するとき)" do
      before do
        allow_any_instance_of(Teams::Poster).to receive(:post).and_return(false)
      end
      it "送信失敗の結果が返ること" do
        expect(result).to be_fail
        expect(result.reason).to eq :fail
        expect(result.message).to eq "status code is not 200"
      end
    end
  end
end
