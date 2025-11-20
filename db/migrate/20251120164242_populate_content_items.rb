class PopulateContentItems < ActiveRecord::Migration[8.0]
  def up
    [ Movie, TvShow, Season, Episode, Channel, ChannelProgram ].each do |model|
      model.find_each do |record|
        record.send(:update_content_item)
      end
    end
  end

  def down
    ContentItem.delete_all
  end
end
