module Pagination
  extend ActiveSupport::Concern

  def pagination(records)
    {
      # 現在のページ
      current_page: records.current_page,
      # 全体のページ
      total_pages: records.total_pages,
    }
  end
end
