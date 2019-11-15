RSpec.describe WeekdayClient do
  let(:client) { WeekdayClient.new("https://example.com/webhook/url/xxxxx/xxxxx") }
  describe "#post" do
    subject(:result) { client.post("message") }
    context "(平日のとき)" do
      before do
        allow_any_instance_of(Dates::DateClient).to receive(:holiday_date?).and_return(false)
      end
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

    context "(平日以外のとき)" do
      before do
        allow_any_instance_of(Dates::DateClient).to receive(:holiday_date?).and_return(true)
      end
      it "送信を行わない結果が返ること" do
        expect(result).to be_fail
        expect(result.reason).to eq :not_post
        expect(result.message).to eq "Today is not weekday"
      end
    end
  end
end
