RSpec.describe Dates::Policies::DatePolicy do
  let(:policy)     { Dates::Policies::DatePolicy.new(given_date) }
  let(:given_date) { Date.parse(test_date) }
  describe "#holiday_date?" do
    subject { policy.holiday_date? }
    describe "[trueが返るパターン]" do
      context "(土曜日のとき)" do
        let(:test_date) { "2019/11/16" }
        it { is_expected.to eq true }
      end

      context "(日曜日のとき)" do
        let(:test_date) { "2019/11/17" }
        it { is_expected.to eq true }
      end

      context "(祝日のとき)" do
        let(:test_date) { "2019/10/14" }
        it { is_expected.to eq true }
      end
    end

    describe "[falseが返るパターン]" do
      context "(月曜日のとき)" do
        let(:test_date) { "2019/11/11" }
        it { is_expected.to eq false }
      end

      context "(火曜日のとき)" do
        let(:test_date) { "2019/11/12" }
        it { is_expected.to eq false }
      end

      context "(水曜日のとき)" do
        let(:test_date) { "2019/11/13" }
        it { is_expected.to eq false }
      end
      context "(木曜日のとき)" do
        let(:test_date) { "2019/11/14" }
        it { is_expected.to eq false }
      end

      context "(金曜日のとき)" do
        let(:test_date) { "2019/11/15" }
        it { is_expected.to eq false }
      end
    end
  end

  describe "#today_match_day?" do
    subject { policy.today_match_day?(given_day) }
    context "(2020/01/10のとき)" do
    let(:test_date) { "2020/01/10" }
      describe "[trueが返るパターン]" do
        context "(日付と引数に渡す数が一致とき)" do
          let(:given_day) { 10 }
          it { is_expected.to eq true }
        end
      end

      describe "[falseが返るパターン]" do
        context "(日付と引数に渡す数が一致しないとき)" do
          let(:given_day) { 11 }
          it { is_expected.to eq false }
        end
      end
    end
  end

  describe "#week_of_day?" do
    subject { policy. week_of_day?(given_week_of_day) }
    context "(月曜日のとき)" do
    let(:test_date) { "2019/11/11" }
      describe "[trueが返るパターン]" do
        context "(mondayを指定するとき)" do
          let(:given_week_of_day) { :monday }
          it { is_expected.to eq true }
        end
      end

      describe "[falseが返るパターン]" do
        context "(monday以外を指定するとき)" do
          let(:given_week_of_day) { :friday }
          it { is_expected.to eq false }
        end
      end
    end

    context "(火曜日のとき)" do
    let(:test_date) { "2019/11/12" }
      describe "[trueが返るパターン]" do
        context "(tuesdayを指定するとき)" do
          let(:given_week_of_day) { :tuesday }
          it { is_expected.to eq true }
        end
      end

      describe "[falseが返るパターン]" do
        context "(tuesday以外を指定するとき)" do
          let(:given_week_of_day) { :friday }
          it { is_expected.to eq false }
        end
      end
    end

    context "(水曜日のとき)" do
    let(:test_date) { "2019/11/13" }
      describe "[trueが返るパターン]" do
        context "(wednesdayを指定するとき)" do
          let(:given_week_of_day) { :wednesday }
          it { is_expected.to eq true }
        end
      end

      describe "[falseが返るパターン]" do
        context "(wednesday以外を指定するとき)" do
          let(:given_week_of_day) { :friday }
          it { is_expected.to eq false }
        end
      end
    end

    context "(木曜日のとき)" do
    let(:test_date) { "2019/11/14" }
      describe "[trueが返るパターン]" do
        context "(thursdayを指定するとき)" do
          let(:given_week_of_day) { :thursday }
          it { is_expected.to eq true }
        end
      end

      describe "[falseが返るパターン]" do
        context "(thursday以外を指定するとき)" do
          let(:given_week_of_day) { :friday }
          it { is_expected.to eq false }
        end
      end
    end

    context "(金曜日のとき)" do
    let(:test_date) { "2019/11/15" }
      describe "[trueが返るパターン]" do
        context "(fridayを指定するとき)" do
          let(:given_week_of_day) { :friday }
          it { is_expected.to eq true }
        end
      end

      describe "[falseが返るパターン]" do
        context "(friday以外を指定するとき)" do
          let(:given_week_of_day) { :monday }
          it { is_expected.to eq false }
        end
      end
    end
  end
end
