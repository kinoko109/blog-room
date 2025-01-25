require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  context "factoryｂのデフォルト設定に従った場合" do
    let(:user) { create(:user) }

    it "認証済みの user レコードを正常に新規作成できる" do
      # user は valid であること（バリデーションエラーがないこと）」を検証
      expect(user).to be_valid
      # user が認証済み（confirmed_atカラムに値が含まれていること）も検証
      expect(user).to be_confirmed
    end
  end
end
