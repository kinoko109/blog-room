class Api::V1::ArticlesController < ApplicationController
  include Pagination

  def index
    # N + 1問題によりSQLを最適化
    # articles = Article.published.order(created_at: :desc).page(params[:page] || 1).per(10)

    # includesは関連先のテーブルのレコードをキャッシュとして取得するメソッド
    # 他にも色々なメソッドがある　https://qiita.com/k0kubun/items/80c5a5494f53bb88dc58
    articles = Article.published.order(created_at: :desc).page(params[:page] || 1).per(10).includes(:user)

    # pagination(articles)で「現在のページ数」「全体のページ数」を生成
    # meta: ページ情報をレスポンスのメタ情報として仕込み
    # adapter: メタ情報をレスポンスjsonに統合する
    render json: articles, meta: pagination(articles), adapter: :json
  end

  def show
    # enumの機能でArticle.where(status: "published")を略してかける
    article = Article.published.find(params[:id])

    # serializerを指定しない場合、モデルと同名のArticleSerializerが自動的に参照されるルールとなる
    render json: article
  end
end
