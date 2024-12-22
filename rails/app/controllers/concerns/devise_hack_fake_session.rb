module DeviseHackFakeSession
  # ActiveSupport::Concernをextendすることで、
  # このモジュールはRailsのbefore_actionなどを含むコールバックや、includedブロックを活用できるようになる
  extend ActiveSupport::Concern

  class FakeSession < Hash
    # 通常のセッションが有効でないことを明示するため
    def enabled?
      false
    end

    def destroy
    end
  end

  # モジュールが他のクラスにインクルードされた際に自動で設定される処理
  # before_action :set_fake_sessionを設定して、コントローラー内の全アクション実行前にset_fake_sessionメソッドが呼び出されるようにしている
  included do
    before_action :set_fake_session

    private

      def set_fake_session
        # RailsがAPIモードかどうかを確認
        if Rails.configuration.respond_to?(:api_only) && Rails.configuration.api_only
          request.env["rack.session"] ||= ::DeviseHackFakeSession::FakeSession.new
        end
      end
  end
end
