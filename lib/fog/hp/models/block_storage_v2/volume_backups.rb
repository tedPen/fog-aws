require 'fog/core/collection'
require 'fog/hp/models/block_storage_v2/volume_backup'

module Fog
  module HP
    class BlockStorageV2

      class VolumeBackups < Fog::Collection

        attribute :filters

        model Fog::HP::BlockStorageV2::VolumeBackup

        def initialize(attributes)
          self.filters ||= {}
          super
        end

        def all(filters = filters)
          details = filters.delete(:details)
          self.filters = filters
          if details
            data = service.list_volume_backups_detail(filters).body['backups']
          else
            data = service.list_volume_backups(filters).body['backups']
          end
          load(data)
        end

        def get(backup_id)
          backup = service.get_volume_backup_details(backup_id).body['backup']
          new(backup)
        rescue Fog::HP::BlockStorageV2::NotFound
          nil
        end

      end

    end
  end
end
