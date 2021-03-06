class Gwfaq::Script::Task < System::Script::Base

  def self.preparation_delete
    run do
      log "質問管理(FAQ)期限切れデータ削除処理: #{I18n.l(limit_date_for_preparation)} 以前を削除" do
        Gwfaq::Control.find_each do |title|
          log "#{title.class}: id: #{title.id}, title: #{title.title}"
          del = destroy_record(title)
          log "#{del} deleted"
        end
      end
    end
  end

  private

  def self.destroy_record(title)
    del = 0
    title.docs.where(state: 'preparation').created_before(limit_date_for_preparation).find_each do |doc|
      if doc.destroy
        del += 1
      end
    end
    del
  end
end
