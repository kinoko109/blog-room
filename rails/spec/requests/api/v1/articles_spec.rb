require 'rails_helper'

RSpec.describe "Api::V1::Articles", type: :request do
  # describe "GET /index" do
  #   pending "add some examples (or delete) #{__FILE__}"
  # end

  describe "GET api/v1/articles" do
    # subject テスト対象（オブジェクトや処理）を定義するためのヘルパーメソッド
    subject { get(api_v1_articles_path(params)) } # APIエンドポイントに GET リクエストを送る処理

    before do
      # RSpec と FactoryBot を使ったテスト環境で利用される便利なメソッド
      create_list(:article, 25, status: :published)
    end

    context "pageをparamsで送信しないとき" do
      # RSpec の遅延評価（lazy evaluation）を行うヘルパーメソッド
      let(:params) { nil }

      it "1ページ目のレコード10件取得できる" do
        subject
        res = JSON.parse(response.body)

        expect(res.keys).to eq ["articles", "meta"]
        expect(res["articles"].length).to eq 10
        expect(res["articles"][0].keys).to eq ["id", "title", "content", "created_at", "from_today", "user"]
        expect(res["articles"][0]["user"].keys).to eq ["name"]
        expect(res["meta"].keys).to eq ["current_page", "total_pages"]
        expect(res["meta"]["current_page"]).to eq 1
        expect(res["meta"]["total_pages"]).to eq 3
        expect(response).to have_http_status(:ok)
      end
    end

    context "pageをparamsで送信したとき" do
      let(:params) { { page: 2 } }

      it "該当ページ目のレコード10件取得できる" do
        subject
        res = JSON.parse(response.body)
        expect(res.keys).to eq ["articles", "meta"]
        expect(res["articles"].length).to eq 10
        expect(res["articles"][0].keys).to eq ["id", "title", "content", "created_at", "from_today", "user"]
        expect(res["articles"][0]["user"].keys).to eq ["name"]
        expect(res["meta"].keys).to eq ["current_page", "total_pages"]
        expect(res["meta"]["current_page"]).to eq 2
        expect(res["meta"]["total_pages"]).to eq 3
        expect(response).to have_http_status(:ok)
      end
    end

    describe "GET api/v1/articles/:id" do
      subject { get(api_v1_article_path(article_id)) }

      # 「status: status」 の省略形
      let(:article) { create(:article, status:) }

      context "article_id に対応する articles レコードが存在する時" do
        let(:article_id) { article.id }

        context "articles レコードのステータスが公開中の時" do
          let(:status) { :published }

          it "正常にレコードを取得できる" do
            subject
            res = JSON.parse(response.body)
            expect(res.keys).to eq ["id", "title", "content", "created_at", "from_today", "user"]
            expect(res["user"].keys).to eq ["name"]
            expect(response).to have_http_status(:ok)
          end
        end

        context "articles レコードのステータスが下書きの時" do
          let(:status) { :draft }

          it "ActiveRecord::RecordNotFound エラーが返る" do
            expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
          end
        end
      end

      context "article_id に対応する articles レコードが存在しない時" do
        let(:article_id) { 10_000_000_000 }

        it "ActiveRecord::RecordNotFound エラーが返る" do
          expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
  end
end
