RSpec.describe Dates::DateClient do
  let(:date_client) { Dates::DateClient.new(Date.today) }
  describe "#holiday_date?" do
    subject { date_client.holiday_date? }
    context "(Dates::DatePolicy#holiday_date?が:calledを返すとき)" do
      before do
        allow_any_instance_of(Dates::Policies::DatePolicy).to receive(:holiday_date?).and_return(:called)
      end
      it { is_expected.to eq :called }
    end
  end

  describe "#week_of_day?" do
    subject { date_client.week_of_day?(:monday) }
    context "(dates::datepolicy#week_of_day?が:calledを返すとき)" do
      before do
        allow_any_instance_of(Dates::Policies::DatePolicy).to receive(:week_of_day?).and_return(:called)
      end
      it { is_expected.to eq :called }
    end
  end

  describe "#holiday_date?" do
    subject { date_client.holiday_date? }
    context "(Dates::DatePolicy#holiday_date?が:calledを返すとき)" do
      before do
        allow_any_instance_of(Dates::Policies::DatePolicy).to receive(:holiday_date?).and_return(:called)
      end
      it { is_expected.to eq :called }
    end
  end

  describe "#today_match_day?" do
    subject { date_client.today_match_day?(25) }
    context "(Dates::DatePolicy#today_match_day?が:calledを返すとき)" do
      before do
        allow_any_instance_of(Dates::Policies::DatePolicy).to receive(:today_match_day?).and_return(:called)
      end
      it { is_expected.to eq :called }
    end
  end
end
