RSpec.describe TargetDateClient do
  let(:client) { TargetDateClient.new("https://example.com/webhook/url/xxxxx/xxxxx") }
  describe "#post" do
    context "(日付指定が1つだけのとき)" do
      subject(:result) { client.post("message", 10) }
      context "(指定した日付と現在日付が同じのとき)" do
        before do
          allow_any_instance_of(Dates::DateClient).to receive(:today_match_day?).and_return(false)
          allow_any_instance_of(Dates::DateClient).to receive(:today_match_day?).with(10).and_return(true)
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

      context "(指定した日付と現在日付が異なるとき)" do
        before do
          allow_any_instance_of(Dates::DateClient).to receive(:today_match_day?).and_return(true)
          allow_any_instance_of(Dates::DateClient).to receive(:today_match_day?).with(10).and_return(false)
        end
        it "送信を行わない結果が返ること" do
          expect(result).to be_fail
          expect(result.reason).to eq :not_post
          expect(result.message).to eq "Today is not 10 day"
        end
      end
    end

    context "(日付指定が複数のとき)" do
      subject(:result) { client.post("message", [11, 12]) }
      context "(指定した日付と現在日付が同じのとき)" do
        before do
          allow_any_instance_of(Dates::DateClient).to receive(:today_match_day?).and_return(false)
          allow_any_instance_of(Dates::DateClient).to receive(:today_match_day?).with(12).and_return(true)
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

      context "(指定した日付と現在日付が異なるとき)" do
        before do
          allow_any_instance_of(Dates::DateClient).to receive(:today_match_day?).and_return(true)
          allow_any_instance_of(Dates::DateClient).to receive(:today_match_day?).with(11).and_return(false)
          allow_any_instance_of(Dates::DateClient).to receive(:today_match_day?).with(12).and_return(false)
        end
        it "送信を行わない結果が返ること" do
          expect(result).to be_fail
          expect(result.reason).to eq :not_post
          expect(result.message).to eq "Today is not [11, 12] day"
        end
      end
    end

    context "(現在日付以外を使用するとき)" do
      subject(:result) { client.post("message", 11) }
      context "(指定日付以外の日付を設定するとき)" do
        before do
          Client.configure do |config|
            # 木曜日
            config.today_date = Date.parse("2019/11/14")
          end
        end

        it "送信を行わない結果が返ること" do
          expect(result).to be_fail
          expect(result.reason).to eq :not_post
          expect(result.message).to eq "Today is not 11 day"
        end
      end

      context "(指定曜日の日付を設定するとき)" do
        before do
          Client.configure do |config|
            # 月曜日
            config.today_date = Date.parse("2019/11/11")
          end
          allow_any_instance_of(Teams::Poster).to receive(:post).and_return(true)
        end

        it "送信成功の結果が返ること" do
          expect(result).to be_ok
          expect(result.reason).to eq :success
          expect(result.message).to eq "status code 200"
        end
      end
    end
  end
end
