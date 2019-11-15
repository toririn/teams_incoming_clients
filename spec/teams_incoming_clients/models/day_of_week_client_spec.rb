RSpec.describe DayOfWeekClient do
  let(:client) { DayOfWeekClient.new("https://example.com/webhook/url/xxxxx/xxxxx") }
  describe "#post" do
    context "(曜日指定が1つだけのとき)" do
      subject(:result) { client.post("message", :monday) }
      context "(指定した曜日と現在曜日が同じのとき)" do
        before do
          allow_any_instance_of(Dates::DateClient).to receive(:week_of_day?).and_return(false)
          allow_any_instance_of(Dates::DateClient).to receive(:week_of_day?).with(:monday).and_return(true)
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

      context "(指定した曜日と現在曜日が異なるとき)" do
        before do
          allow_any_instance_of(Dates::DateClient).to receive(:week_of_day?).and_return(true)
          allow_any_instance_of(Dates::DateClient).to receive(:week_of_day?).with(:monday).and_return(false)
        end
        it "送信を行わない結果が返ること" do
          expect(result).to be_fail
          expect(result.reason).to eq :not_post
          expect(result.message).to eq "Today is not monday"
        end
      end
    end

    context "(曜日指定が複数のとき)" do
      subject(:result) { client.post("message", [:monday, :friday]) }
      context "(指定した曜日と現在曜日が同じのとき)" do
        before do
          allow_any_instance_of(Dates::DateClient).to receive(:week_of_day?).and_return(false)
          allow_any_instance_of(Dates::DateClient).to receive(:week_of_day?).with(:friday).and_return(true)
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

      context "(指定した曜日と現在曜日が異なるとき)" do
        before do
          allow_any_instance_of(Dates::DateClient).to receive(:week_of_day?).and_return(true)
          allow_any_instance_of(Dates::DateClient).to receive(:week_of_day?).with(:monday).and_return(false)
          allow_any_instance_of(Dates::DateClient).to receive(:week_of_day?).with(:friday).and_return(false)
        end
        it "送信を行わない結果が返ること" do
          expect(result).to be_fail
          expect(result.reason).to eq :not_post
          expect(result.message).to eq "Today is not [:monday, :friday]"
        end
      end
    end

    context "(現在曜日以外を使用するとき)" do
      subject(:result) { client.post("message", :monday) }
      context "(指定曜日以外の日付を設定するとき)" do
        before do
          Client.configure do |config|
            # 木曜日
            config.today_date = Date.parse("2019/11/14")
          end
        end

        it "送信を行わない結果が返ること" do
          expect(result).to be_fail
          expect(result.reason).to eq :not_post
          expect(result.message).to eq "Today is not monday"
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
